#include <stdlib.h>

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

typedef struct {
    unsigned long long key;
    int count;
    int occupied;
} HashEntry;

HashEntry* hashTable;
int hashTableSize;

void initHashTable(int size) {
    hashTableSize = size;
    hashTable = (HashEntry*)calloc(hashTableSize, sizeof(HashEntry));
}

void freeHashTable() {
    free(hashTable);
    hashTable = NULL;
}

unsigned int hash(unsigned long long key) {
    return key % hashTableSize;
}

void insertOrUpdate(int num, int den) {
    unsigned long long key = ((unsigned long long)num << 32) | den;
    unsigned int index = hash(key);

    while (hashTable[index].occupied) {
        if (hashTable[index].key == key) {
            hashTable[index].count++;
            return;
        }
        index = (index + 1) % hashTableSize;
    }

    hashTable[index].key = key;
    hashTable[index].count = 1;
    hashTable[index].occupied = 1;
}

long long interchangeableRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    initHashTable(rectanglesSize * 2 + 7);

    for (int i = 0; i < rectanglesSize; i++) {
        int w = rectangles[i][0];
        int h = rectangles[i][1];

        int commonDivisor = gcd(w, h);
        int simplifiedW = w / commonDivisor;
        int simplifiedH = h / commonDivisor;

        insertOrUpdate(simplifiedW, simplifiedH);
    }

    long long totalPairs = 0;
    for (int i = 0; i < hashTableSize; i++) {
        if (hashTable[i].occupied) {
            long long count = hashTable[i].count;
            if (count >= 2) {
                totalPairs += count * (count - 1) / 2;
            }
        }
    }

    freeHashTable();

    return totalPairs;
}