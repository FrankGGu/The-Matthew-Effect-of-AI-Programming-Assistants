#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int value;
} Pair;

typedef struct {
    Pair *items;
    int size;
} HashTable;

int hash(char *s) {
    int h = 0;
    while (*s) {
        h = (h * 131 + *s++) % 1000000;
    }
    return h;
}

void insert(HashTable *ht, char *key, int value) {
    int index = hash(key);
    for (int i = 0; i < ht->size; i++) {
        if (ht->items[i].key && strcmp(ht->items[i].key, key) == 0) {
            ht->items[i].value = value;
            return;
        }
    }
    for (int i = 0; i < ht->size; i++) {
        if (!ht->items[i].key) {
            ht->items[i].key = strdup(key);
            ht->items[i].value = value;
            return;
        }
    }
}

int get(HashTable *ht, char *key) {
    int index = hash(key);
    for (int i = 0; i < ht->size; i++) {
        if (ht->items[i].key && strcmp(ht->items[i].key, key) == 0) {
            return ht->items[i].value;
        }
    }
    return -1;
}

void freeHashTable(HashTable *ht) {
    for (int i = 0; i < ht->size; i++) {
        free(ht->items[i].key);
    }
    free(ht->items);
}

int* smallestSufficientTeam(char** required, int requiredSize, char** people, int peopleSize, int* returnSize) {
    int n = requiredSize;
    int m = peopleSize;

    HashTable ht;
    ht.size = 10000;
    ht.items = (Pair *)calloc(ht.size, sizeof(Pair));

    for (int i = 0; i < n; i++) {
        insert(&ht, required[i], i);
    }

    int skillMask[n];
    for (int i = 0; i < n; i++) {
        skillMask[i] = 0;
    }

    for (int i = 0; i < m; i++) {
        char *p = people[i];
        int mask = 0;
        char *token = strtok(p, ",");
        while (token) {
            int idx = get(&ht, token);
            if (idx != -1) {
                mask |= (1 << idx);
            }
            token = strtok(NULL, ",");
        }
        skillMask[i] = mask;
    }

    int dp[1 << n];
    int parent[1 << n];
    memset(dp, -1, sizeof(dp));
    dp[0] = 0;
    for (int i = 0; i < (1 << n); i++) {
        if (dp[i] == -1) continue;
        for (int j = 0; j < m; j++) {
            int newMask = i | skillMask[j];
            if (dp[newMask] == -1 || dp[i] + 1 < dp[newMask]) {
                dp[newMask] = dp[i] + 1;
                parent[newMask] = j;
            }
        }
    }

    int target = (1 << n) - 1;
    int *result = (int *)malloc(sizeof(int) * m);
    int count = 0;
    int current = target;
    while (current > 0) {
        int person = parent[current];
        result[count++] = person;
        current = current & (~skillMask[person]);
    }

    *returnSize = count;
    freeHashTable(&ht);
    return result;
}