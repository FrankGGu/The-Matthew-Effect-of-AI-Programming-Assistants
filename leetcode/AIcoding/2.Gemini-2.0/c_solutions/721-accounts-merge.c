#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* email;
    int account_index;
} EmailAccount;

int find(int* parent, int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void union_sets(int* parent, int* rank, int a, int b) {
    a = find(parent, a);
    b = find(parent, b);
    if (a != b) {
        if (rank[a] < rank[b])
            {int temp = a; a = b; b = temp;}
        parent[b] = a;
        if (rank[a] == rank[b])
            rank[a]++;
    }
}

char*** accountsMerge(char*** accounts, int accountsSize, int* accountsColSize, int* returnSize, int** returnColumnSizes) {
    int* parent = (int*)malloc(sizeof(int) * accountsSize);
    int* rank = (int*)malloc(sizeof(int) * accountsSize);
    for (int i = 0; i < accountsSize; i++) {
        parent[i] = i;
        rank[i] = 0;
    }

    int email_count = 0;
    EmailAccount* email_to_account = NULL;
    int* email_index_map = (int*)malloc(sizeof(int) * 10000);
    for (int i = 0; i < 10000; i++) {
        email_index_map[i] = -1;
    }

    for (int i = 0; i < accountsSize; i++) {
        for (int j = 1; j < accountsColSize[i]; j++) {
            int email_hash = 0;
            for (int k = 0; accounts[i][j][k] != '\0'; k++) {
                email_hash = (email_hash * 31) + accounts[i][j][k];
            }
            email_hash = abs(email_hash % 10000);

            if (email_index_map[email_hash] == -1) {
                email_index_map[email_hash] = email_count;
                email_count++;
                email_to_account = (EmailAccount*)realloc(email_to_account, sizeof(EmailAccount) * email_count);
                email_to_account[email_count - 1].email = accounts[i][j];
                email_to_account[email_count - 1].account_index = i;
            } else {
                int index = email_index_map[email_hash];
                union_sets(parent, rank, i, email_to_account[index].account_index);
            }
        }
    }

    int* account_size = (int*)calloc(accountsSize, sizeof(int));
    char*** merged_accounts = (char***)malloc(sizeof(char**) * accountsSize);
    for (int i = 0; i < accountsSize; i++) {
        merged_accounts[i] = (char**)malloc(sizeof(char*) * accountsColSize[i]); 
    }

    for (int i = 0; i < email_count; i++) {
        int root = find(parent, email_to_account[i].account_index);
        merged_accounts[root][account_size[root]] = email_to_account[i].email;
        account_size[root]++;
    }

    int num_merged_accounts = 0;
    for (int i = 0; i < accountsSize; i++) {
        if (account_size[i] > 0) {
            num_merged_accounts++;
        }
    }

    char*** result = (char***)malloc(sizeof(char**) * num_merged_accounts);
    *returnColumnSizes = (int*)malloc(sizeof(int) * num_merged_accounts);
    *returnSize = num_merged_accounts;

    int result_index = 0;
    for (int i = 0; i < accountsSize; i++) {
        if (account_size[i] > 0) {
            result[result_index] = (char**)malloc(sizeof(char*) * (account_size[i] + 1));
            (*returnColumnSizes)[result_index] = account_size[i] + 1;
            result[result_index][0] = accounts[i][0];

            char** emails = (char**)malloc(sizeof(char*) * account_size[i]);
            for(int j = 0; j < account_size[i]; j++) {
                emails[j] = merged_accounts[i][j];
            }

            for (int j = 0; j < account_size[i]; j++) {
                for (int k = j + 1; k < account_size[i]; k++) {
                    if (strcmp(emails[j], emails[k]) > 0) {
                        char* temp = emails[j];
                        emails[j] = emails[k];
                        emails[k] = temp;
                    }
                }
            }

            for (int j = 0; j < account_size[i]; j++) {
                result[result_index][j + 1] = emails[j];
            }

            free(emails);
            result_index++;
        }
    }

    free(parent);
    free(rank);
    free(email_index_map);
    free(email_to_account);
    for (int i = 0; i < accountsSize; i++) {
        free(merged_accounts[i]);
    }
    free(merged_accounts);
    free(account_size);

    return result;
}