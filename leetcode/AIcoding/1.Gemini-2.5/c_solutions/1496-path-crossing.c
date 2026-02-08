#include <stdbool.h>
#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

typedef struct Point {
    int x;
    int y;
} Point;

typedef struct HashEntry {
    Point p;
    struct HashEntry* next;
} HashEntry;

#define TABLE_SIZE 20003 // A prime number, roughly 2 * max_path_length + 1
HashEntry* hashTable[TABLE_SIZE];

unsigned int hash(int x, int y) {
    // Combine x and y into a single value, use large primes to reduce collisions
    // Use long long for intermediate calculation to prevent overflow before modulo
    long long val = (long long)x * 31 + y * 37;
    // Ensure the hash index is non-negative
    return (unsigned int)((val % TABLE_SIZE + TABLE_SIZE) % TABLE_SIZE);
}

bool addAndCheck(int x, int y) {
    unsigned int index = hash(x, y);
    HashEntry* current = hashTable[index];

    // Traverse the linked list at this hash index to check for duplicates
    while (current != NULL) {
        if (current->p.x == x && current->p.y == y) {
            return true; // Point found, path crosses
        }
        current = current->next;
    }

    // Point not found, so add it to the front of the list
    HashEntry* newEntry = (HashEntry*)malloc(sizeof(HashEntry));
    newEntry->p.x = x;
    newEntry->p.y = y;
    newEntry->next = hashTable[index];
    hashTable[index] = newEntry;

    return false; // Point added, no crossing detected yet
}

void freeHashTable() {
    for (int i = 0; i < TABLE_SIZE; ++i) {
        HashEntry* current = hashTable[i];
        while (current != NULL) {
            HashEntry* temp = current;
            current = current->next;
            free(temp);
        }
        hashTable[i] = NULL; // Reset pointer for next use
    }
}

bool isPathCrossing(char* path) {
    // Initialize the hash table by setting all pointers to NULL.
    // This ensures a clean state for each test case.
    memset(hashTable, 0, sizeof(hashTable));

    int currentX = 0;
    int currentY = 0;

    // Add the starting point (0,0) to the set of visited points.
    // We don't use addAndCheck here because (0,0) is guaranteed to be new.
    HashEntry* initialEntry = (HashEntry*)malloc(sizeof(HashEntry));
    initialEntry->p.x = 0;
    initialEntry->p.y = 0;
    unsigned int initialIndex = hash(0, 0);
    initialEntry->next = hashTable[initialIndex];
    hashTable[initialIndex] = initialEntry;

    // Iterate through the path string
    for (int i = 0; path[i] != '\0'; ++i) {
        char move = path[i];
        switch (move) {
            case 'N':
                currentY++;
                break;
            case 'S':
                currentY--;
                break;
            case 'E':
                currentX++;
                break;
            case 'W':
                currentX--;
                break;
        }

        // After moving, check if the new coordinate has been visited before
        if (addAndCheck(currentX, currentY)) {
            freeHashTable(); // Clean up memory before returning true
            return true;     // Path crosses itself
        }
    }

    freeHashTable(); // Clean up memory before returning false
    return false;    // Path does not cross itself
}