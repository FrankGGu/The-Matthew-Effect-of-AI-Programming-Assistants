#include <stdlib.h>
#include <string.h>
#include <stdio.h> // Potentially for debugging, typically not needed for submission

int* parent;
int dsu_max_id; // Max ID used in DSU, which is the total count of unique emails

void dsu_init(int max_id) {
    dsu_max_id = max_id;
    parent = (int*)malloc(dsu_max_id * sizeof(int));
    for (int i = 0; i < dsu_max_id; ++i) {
        parent[i] = i;
    }
}

int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]); // Path compression
}

void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        parent[root_j] = root_i; // Simple union
    }
}

#define HASH_TABLE_SIZE 20000 
#define INITIAL_ID_TO_EMAIL_CAPACITY 1024 // Initial capacity for id_to_email array
#define INITIAL_EMAIL_GROUP_CAPACITY 10   // Initial capacity for emails within a merged group
#define INITIAL_RESULT_CAPACITY 100       // Initial capacity for the final result array

typedef struct EmailNode {
    char* email;
    int id;
    struct EmailNode* next;
} EmailNode;

EmailNode** email_hash_table;
char** id_to_email; // Maps ID back to email string (points to strings owned by EmailNodes)
int current_email_id_counter; // Next available ID
int id_to_email_capacity;     // Current capacity of id_to_email array

unsigned int hash_string(const char* str) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    return hash % HASH_TABLE_SIZE;
}

int get_email_id(const char* email) {
    unsigned int h = hash_string(email);
    EmailNode* node = email_hash_table[h];

    // Search for the email in the linked list at this hash bucket
    while (node != NULL) {
        if (strcmp(node->email, email) == 0) {
            return node->id;
        }
        node = node->next;
    }

    // Email not found, add it
    node = (EmailNode*)malloc(sizeof(EmailNode));
    node->email = strdup(email); // Duplicate string for ownership by hash table
    node->id = current_email_id_counter++;
    node->next = email_hash_table[h];
    email_hash_table[h] = node;

    // Expand id_to_email array if needed
    if (node->id >= id_to_email_capacity) {
        id_to_email_capacity *= 2;
        id_to_email = (char**)realloc(id_to_email, id_to_email_capacity * sizeof(char*));
    }
    id_to_email[node->id] = node->email; // Store pointer to the strdup'd string

    return node->id;
}

typedef struct {
    char** emails;
    int count;
    int capacity;
} EmailGroup;

int compareStrings(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

char*** accountsMerge(char*** accounts, int accountsSize, int* accountsColSize, int* returnSize, int** returnColumnSizes) {
    // Initialize hash table and ID mapping structures
    email_hash_table = (EmailNode**)calloc(HASH_TABLE_SIZE, sizeof(EmailNode*));
    id_to_email = (char**)malloc(INITIAL_ID_TO_EMAIL_CAPACITY * sizeof(char*));
    current_email_id_counter = 0;
    id_to_email_capacity = INITIAL_ID_TO_EMAIL_CAPACITY;

    // First pass: Populate email_to_id and id_to_email, determine total unique emails
    for (int i = 0; i < accountsSize; ++i) {
        // accountsColSize[i] is the number of strings in accounts[i].
        // accounts[i][0] is the name, accounts[i][1] onwards are emails.
        // So start from j=1 for emails.
        for (int j = 1; j < accountsColSize[i]; ++j) {
            get_email_id(accounts[i][j]);
        }
    }

    // Initialize DSU with the total number of unique emails found
    dsu_init(current_email_id_counter);

    // Second pass: Perform unions based on accounts
    for (int i = 0; i < accountsSize; ++i) {
        if (accountsColSize[i] > 1) { // Account must have at least one email
            int first_email_id = get_email_id(accounts[i][1]); // Get ID for the first email in the account
            for (int j = 2; j < accountsColSize[i]; ++j) {
                int current_email_id = get_email_id(accounts[i][j]); // Get ID for subsequent emails
                unite(first_email_id, current_email_id);             // Union them with the first email
            }
        }
    }

    // Group emails by their root ID and assign names to the merged groups
    EmailGroup** groups_by_root = (EmailGroup**)calloc(current_email_id_counter, sizeof(EmailGroup*));
    char** root_to_name = (char**)calloc(current_email_id_counter, sizeof(char*));

    // Populate groups_by_root with emails
    for (int i = 0; i < current_email_id_counter; ++i) { // Iterate through all unique email IDs
        int root_id = find(i); // Find the representative root for this email's set
        if (groups_by_root[root_id] == NULL) {
            // Initialize a new EmailGroup for this root if it's the first time we see it
            groups_by_root[root_id] = (EmailGroup*)malloc(sizeof(EmailGroup));
            groups_by_root[root_id]->emails = (char**)malloc(INITIAL_EMAIL_GROUP_CAPACITY * sizeof(char*));
            groups_by_root[root_id]->count = 0;
            groups_by_root[root_id]->capacity = INITIAL_EMAIL_GROUP_CAPACITY;
        }

        // Add the current email to its corresponding group
        if (groups_by_root[root_id]->count == groups_by_root[root_id]->capacity) {
            groups_by_root[root_id]->capacity *= 2;
            groups_by_root[root_id]->emails = (char**)realloc(groups_by_root[root_id]->emails, groups_by_root[root_id]->capacity * sizeof(char*));
        }
        groups_by_root[root_id]->emails[groups_by_root[root_id]->count++] = id_to_email[i];
    }

    // Assign names to roots (each merged group takes a name from one of its original accounts)
    for (int i = 0; i < accountsSize; ++i) {
        if (accountsColSize[i] > 1) {
            int first_email_id = get_email_id(accounts[i][1]);
            int root_id = find(first_email_id);
            if (root_to_name[root_id] == NULL) {
                root_to_name[root_id] = accounts[i][0]; // Store pointer to original name string (read-only)
            }
        }
    }

    // Construct the final result array
    char*** result = (char***)malloc(INITIAL_RESULT_CAPACITY * sizeof(char**));
    *returnColumnSizes = (int*)malloc(INITIAL_RESULT_CAPACITY * sizeof(int));
    int result_count = 0;
    int result_capacity = INITIAL_RESULT_CAPACITY;

    for (int i = 0; i < current_email_id_counter; ++i) { // Iterate through all possible root IDs
        if (groups_by_root[i] != NULL) { // If 'i' is actually a root that has emails associated with it
            EmailGroup* group = groups_by_root[i];
            char* name = root_to_name[i];

            // Sort emails alphabetically within the group
            qsort(group->emails, group->count, sizeof(char*), compareStrings);

            // Create a new entry for this merged account in the final result format
            char** merged_account_entry = (char**)malloc((group->count + 1) * sizeof(char*));
            merged_account_entry[0] = name; // First element is the account name
            for (int j = 0; j < group->count; ++j) {
                merged_account_entry[j + 1] = group->emails[j]; // Subsequent elements are sorted emails
            }

            // Add the newly created merged account entry to the result array
            if (result_count == result_capacity) {
                result_capacity *= 2;
                result = (char***)realloc(result, result_capacity * sizeof(char**));
                *returnColumnSizes = (int*)realloc(*returnColumnSizes, result_capacity * sizeof(int));
            }
            result[result_count] = merged_account_entry;
            (*returnColumnSizes)[result_count] = group->count + 1;
            result_count++;
        }
    }
    *returnSize = result_count; // Set the total number of merged accounts

    // --- Cleanup: Free all dynamically allocated memory ---

    // Free DSU parent array
    free(parent);

    // Free hash table nodes and their duplicated email strings
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        EmailNode* node = email_hash_table[i];
        while (node != NULL) {
            EmailNode* temp = node;
            node = node->next;
            free(temp->email); // Free strdup'd string
            free(temp);        // Free EmailNode itself
        }
    }
    free(email_hash_table); // Free the hash table array

    // Free id_to_email array (the array structure itself; the strings it points to were freed above)
    free(id_to_email);

    // Free EmailGroup structures and their email arrays
    for (int i = 0; i < current_email_id_counter; ++i) {
        if (groups_by_root[i] != NULL) {
            free(groups_by_root[i]->emails); // Free the array of email pointers
            free(groups_by_root[i]);         // Free the EmailGroup struct
        }
    }
    free(groups_by_root); // Free the array of EmailGroup pointers

    // Free root_to_name array (points to original input strings, so no need to free strings themselves)
    free(root_to_name);

    return result;
}