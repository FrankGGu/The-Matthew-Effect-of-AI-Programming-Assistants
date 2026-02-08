#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_VARS 400
#define HASH_TABLE_SIZE 1000

typedef struct StringToIntMapEntry {
    char* key;
    int value;
    struct StringToIntMapEntry* next;
} StringToIntMapEntry;

StringToIntMapEntry* hash_table[HASH_TABLE_SIZE];
int next_id = 0;

unsigned long hash_string(char* str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

int get_id(char* str) {
    unsigned long h = hash_string(str) % HASH_TABLE_SIZE;
    StringToIntMapEntry* entry = hash_table[h];

    while (entry != NULL) {
        if (strcmp(entry->key, str) == 0) {
            return entry->value;
        }
        entry = entry->next;
    }

    entry = (StringToIntMapEntry*)malloc(sizeof(StringToIntMapEntry));
    entry->key = (char*)malloc(sizeof(char) * (strlen(str) + 1));
    strcpy(entry->key, str);
    entry->value = next_id;
    entry->next = hash_table[h];
    hash_table[h] = entry;

    next_id++;
    return entry->value;
}

int find_id(char* str) {
    unsigned long h = hash_string(str) % HASH_TABLE_SIZE;
    StringToIntMapEntry* entry = hash_table[h];

    while (entry != NULL) {
        if (strcmp(entry->key, str) == 0) {
            return entry->value;
        }
        entry = entry->next;
    }
    return -1;
}

double graph[MAX_VARS][MAX_VARS];
bool visited[MAX_VARS];

double dfs_matrix(int start_node, int end_node, double current_product) {
    if (start_node == end_node) {
        return current_product;
    }
    visited[start_node] = true;

    for (int i = 0; i < next_id; i++) {
        if (!visited[i] && graph[start_node][i] != -1.0) {
            double result = dfs_matrix(i, end_node, current_product * graph[start_node][i]);
            if (result != -1.0) {
                return result;
            }
        }
    }
    return -1.0;
}

void cleanup() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        StringToIntMapEntry* entry = hash_table[i];
        while (entry != NULL) {
            StringToIntMapEntry* temp = entry;
            entry = entry->next;
            free(temp->key);
            free(temp);
        }
        hash_table[i] = NULL;
    }
    next_id = 0;
}

double* calcEquation(char*** equations, int equationsSize, int* equationsColSize, double* values, int valuesSize, char*** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    cleanup();

    for (int i = 0; i < MAX_VARS; i++) {
        for (int j = 0; j < MAX_VARS; j++) {
            graph[i][j] = -1.0;
        }
    }

    for (int i = 0; i < equationsSize; i++) {
        char* var1_str = equations[i][0];
        char* var2_str = equations[i][1];
        double val = values[i];

        int id1 = get_id(var1_str);
        int id2 = get_id(var2_str);

        graph[id1][id2] = val;
        graph[id2][id1] = 1.0 / val;
    }

    double* results = (double*)malloc(sizeof(double) * queriesSize);
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        char* query_var1_str = queries[i][0];
        char* query_var2_str = queries[i][1];

        int id1 = find_id(query_var1_str);
        int id2 = find_id(query_var2_str);

        if (id1 == -1 || id2 == -1) {
            results[i] = -1.0;
        } else if (id1 == id2) {
            results[i] = 1.0;
        } else {
            for (int j = 0; j < next_id; j++) {
                visited[j] = false;
            }
            results[i] = dfs_matrix(id1, id2, 1.0);
        }
    }

    return results;
}