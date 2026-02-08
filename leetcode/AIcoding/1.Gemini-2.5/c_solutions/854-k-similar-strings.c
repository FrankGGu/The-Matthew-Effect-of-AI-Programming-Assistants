#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#define MAX_STR_LEN 9
#define HASH_TABLE_SIZE 400009 // A prime number slightly larger than 9! (362880)
#define MAX_QUEUE_SIZE 400000  // Max 9! states

typedef struct Node {
    char str[MAX_STR_LEN + 1];
    struct Node* next;
} Node;

Node* hashTable[HASH_TABLE_SIZE];

unsigned long hash(const char *str) {
    unsigned long hash_val = 5381;
    int c;
    while ((c = *str++)) {
        hash_val = ((hash_val << 5) + hash_val) + c; 
    }
    return hash_val % HASH_TABLE_SIZE;
}

bool insert(const char *str) {
    unsigned long idx = hash(str);
    Node* current = hashTable[idx];
    while (current != NULL) {
        if (strcmp(current->str, str) == 0) {
            return false; // Already exists
        }
        current = current->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    strcpy(newNode->str, str);
    newNode->next = hashTable[idx];
    hashTable[idx] = newNode;
    return true; // Inserted
}

void freeHashTable() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        Node* current = hashTable[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL; // Reset bucket head
    }
}

char queue_data[MAX_QUEUE_SIZE][MAX_STR_LEN + 1];
int q_head = 0;
int q_tail = 0; // q_tail points to the next available slot

void enqueue(const char *str) {
    strcpy(queue_data[q_tail], str);
    q_tail = (q_tail + 1) % MAX_QUEUE_SIZE;
}

void dequeue(char *str_out) {
    strcpy(str_out, queue_data[q_head]);
    q_head = (q_head + 1) % MAX_QUEUE_SIZE;
}

bool is_queue_empty() {
    return q_head == q_tail;
}

int queue_size() {
    return (q_tail - q_head + MAX_QUEUE_SIZE) % MAX_QUEUE_SIZE;
}

int kSimilarity(char *s1, char *s2) {
    int n = strlen(s1);

    // Initialize hash table and queue for each test case
    for(int i = 0; i < HASH_TABLE_SIZE; ++i) hashTable[i] = NULL;
    q_head = 0;
    q_tail = 0;

    enqueue(s1);
    insert(s1); // Add initial state to visited set

    int level = 0;

    char current_s[MAX_STR_LEN + 1];
    char next_s[MAX_STR_LEN + 1];

    while (!is_queue_empty()) {
        int level_size = queue_size();
        for (int k = 0; k < level_size; ++k) {
            dequeue(current_s);

            if (strcmp(current_s, s2) == 0) {
                freeHashTable(); // Clean up memory before returning
                return level;
            }

            // Find the first index 'i' where current_s[i] does not match s2[i]
            int i = 0;
            while (i < n && current_s[i] == s2[i]) {
                i++;
            }

            // Generate next states by swapping current_s[i] with some current_s[j]
            // We look for a character s2[i] at some position j > i
            for (int j = i + 1; j < n; ++j) {
                // Condition 1: current_s[j] must be the character we need at position 'i' (i.e., s2[i])
                // Condition 2: current_s[j] must not be the same as current_s[i] to avoid useless swaps
                if (current_s[j] == s2[i] && current_s[j] != current_s[i]) {
                    // Create a new string by swapping current_s[i] and current_s[j]
                    strcpy(next_s, current_s);
                    char temp = next_s[i];
                    next_s[i] = next_s[j];
                    next_s[j] = temp;

                    // If this new state has not been visited, add it to visited set and enqueue
                    if (insert(next_s)) {
                        enqueue(next_s);
                    }
                }
            }
        }
        level++;
    }

    // This part should ideally not be reached if s1 and s2 are guaranteed anagrams and a solution exists.
    freeHashTable();
    return -1; // Should not happen for valid inputs
}