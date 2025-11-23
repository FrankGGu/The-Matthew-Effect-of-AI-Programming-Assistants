#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    struct Node* next;
} Node;

typedef struct {
    Node** table;
    int size;
} HashSet;

HashSet* createHashSet(int size) {
    HashSet* set = (HashSet*)malloc(sizeof(HashSet));
    set->size = size;
    set->table = (Node**)calloc(size, sizeof(Node*));
    return set;
}

unsigned int hash(int key, int size) {
    unsigned int hashVal = 0;
    char* keyStr = (char*)&key;
    for (int i = 0; i < sizeof(int); i++) {
        hashVal = (hashVal * 31) + keyStr[i];
    }
    return hashVal % size;
}

void insert(HashSet* set, int val) {
    int index = hash(val, set->size);
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->val = val;
    newNode->next = set->table[index];
    set->table[index] = newNode;
}

int contains(HashSet* set, int val) {
    int index = hash(val, set->size);
    Node* current = set->table[index];
    while (current != NULL) {
        if (current->val == val) {
            return 1;
        }
        current = current->next;
    }
    return 0;
}

void freeHashSet(HashSet* set) {
    for (int i = 0; i < set->size; i++) {
        Node* current = set->table[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(set->table);
    free(set);
}

int longestConsecutive(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    HashSet* numSet = createHashSet(numsSize * 2);
    for (int i = 0; i < numsSize; i++) {
        insert(numSet, nums[i]);
    }

    int longestStreak = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (!contains(numSet, num - 1)) {
            int currentNum = num;
            int currentStreak = 1;

            while (contains(numSet, currentNum + 1)) {
                currentNum += 1;
                currentStreak += 1;
            }

            if (currentStreak > longestStreak) {
                longestStreak = currentStreak;
            }
        }
    }

    freeHashSet(numSet);
    return longestStreak;
}