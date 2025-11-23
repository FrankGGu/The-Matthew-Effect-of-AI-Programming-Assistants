#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define HASH_TABLE_SIZE 100003

typedef struct Node {
    int val;
    struct Node* next;
} Node;

Node* hashTable[HASH_TABLE_SIZE];

static int calculate_hash(int val) {
    return (val % HASH_TABLE_SIZE + HASH_TABLE_SIZE) % HASH_TABLE_SIZE;
}

static void hash_set_insert(int val) {
    int index = calculate_hash(val);

    Node* current = hashTable[index];
    while (current != NULL) {
        if (current->val == val) {
            return;
        }
        current = current->next;
    }

    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = hashTable[index];
    hashTable[index] = newNode;
}

static bool hash_set_contains(int val) {
    int index = calculate_hash(val);
    Node* current = hashTable[index];
    while (current != NULL) {
        if (current->val == val) {
            return true;
        }
        current = current->next;
    }
    return false;
}

static void hash_set_free() {
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        Node* current = hashTable[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
}

int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    memset(hashTable, 0, sizeof(hashTable));

    for (int i = 0; i < numsSize; i++) {
        hash_set_insert(nums[i]);
    }

    int maxLength = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];

        if (!hash_set_contains(num - 1)) {
            int currentNum = num;
            int currentLength = 1;

            while (hash_set_contains(currentNum + 1)) {
                currentNum++;
                currentLength++;
            }

            if (currentLength > maxLength) {
                maxLength = currentLength;
            }
        }
    }

    hash_set_free();

    return maxLength;
}