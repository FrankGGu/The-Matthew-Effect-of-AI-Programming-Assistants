#include <stdlib.h>

#define HASH_TABLE_SIZE 100003

typedef struct HashNode {
    int key;
    int value;
    struct HashNode *next;
} HashNode;

HashNode *hashTable[HASH_TABLE_SIZE];

unsigned int hash(int key) {
    return (unsigned int)key % HASH_TABLE_SIZE;
}

int get_color_count(int key) {
    unsigned int index = hash(key);
    HashNode *current = hashTable[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return 0;
}

void set_color_count(int key, int value) {
    unsigned int index = hash(key);
    HashNode *current = hashTable[index];
    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }
    HashNode *newNode = (HashNode*) malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->value = value;
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
}

void init_hash_table() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        hashTable[i] = NULL;
    }
}

void free_hash_table() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        HashNode *current = hashTable[i];
        while (current != NULL) {
            HashNode *temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

int* distinctColors(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* ball_colors = (int*) calloc(n, sizeof(int));

    init_hash_table();

    int distinct_colors_count = 0;

    if (n > 0) {
        set_color_count(0, n);
        distinct_colors_count = 1;
    }

    int* results = (int*) malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int ball_idx = queries[i][0];
        int new_color = queries[i][1];
        int old_color = ball_colors[ball_idx];

        if (old_color == new_color) {
            results[i] = distinct_colors_count;
            continue;
        }

        int old_color_current_count = get_color_count(old_color);
        set_color_count(old_color, old_color_current_count - 1);
        if (old_color_current_count == 1) {
            distinct_colors_count--;
        }

        int new_color_current_count = get_color_count(new_color);
        set_color_count(new_color, new_color_current_count + 1);
        if (new_color_current_count == 0) {
            distinct_colors_count++;
        }

        ball_colors[ball_idx] = new_color;

        results[i] = distinct_colors_count;
    }

    free(ball_colors);
    free_hash_table();

    return results;
}