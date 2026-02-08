#include <stdlib.h> // For malloc, free, abs
#include <stdbool.h> // For bool
#include <string.h> // For memset
#include <limits.h> // For INT_MAX

#define HASH_MOD 100003 // A prime number

typedef struct MapEntry {
    int key;
    int value; // Stores minimum days
    struct MapEntry* next;
} MapEntry;

static MapEntry* hashTable[HASH_MOD];
static bool map_has_entries = false; // Flag to indicate if the map contains entries

static int getHash(int key) {
    // For positive integers, modulo is sufficient.
    return key % HASH_MOD;
}

static int* findInMap(int key) {
    int hash = getHash(key);
    MapEntry* entry = hashTable[hash];
    while (entry != NULL) {
        if (entry->key == key) {
            return &(entry->value);
        }
        entry = entry->next;
    }
    return NULL;
}

static void insertOrUpdateMap(int key, int value) {
    int hash = getHash(key);
    MapEntry* entry = hashTable[hash];
    while (entry != NULL) {
        if (entry->key == key) {
            entry->value = value; // Update existing value
            return;
        }
        entry = entry->next;
    }
    // Key not found, create a new entry
    MapEntry* newEntry = (MapEntry*)malloc(sizeof(MapEntry));
    newEntry->key = key;
    newEntry->value = value;
    newEntry->next = hashTable[hash];
    hashTable[hash] = newEntry;
    map_has_entries = true; // Mark that the map now contains entries
}

static void clearMap() {
    for (int i = 0; i < HASH_MOD; i++) {
        MapEntry* entry = hashTable[i];
        while (entry != NULL) {
            MapEntry* temp = entry;
            entry = entry->next;
            free(temp);
        }
        hashTable[i] = NULL;
    }
    map_has_entries = false; // Reset flag
}

static int solve(int n) {
    // Base cases
    if (n <= 1) {
        return n; // 0 oranges -> 0 days, 1 orange -> 1 day
    }

    // Check memoization table
    int* memoized_days = findInMap(n);
    if (memoized_days != NULL) {
        return *memoized_days;
    }

    // Calculate minimum days using the three possible operations
    // Option 1: Eat 1 orange. This costs 1 day + solve(n-1).
    // Option 2: Eat oranges until n is divisible by 2, then divide by 2.
    // This costs (n % 2) days to reach n - (n % 2), then 1 day to reach (n - (n % 2)) / 2.
    // In integer division, (n - (n % 2)) / 2 is simply n / 2.
    // So, cost is (n % 2) + 1 + solve(n / 2).
    // Option 3: Eat oranges until n is divisible by 3, then divide by 3.
    // This costs (n % 3) days to reach n - (n % 3), then 1 day to reach (n - (n % 3)) / 3.
    // In integer division, (n - (n % 3)) / 3 is simply n / 3.
    // So, cost is (n % 3) + 1 + solve(n / 3).

    int days_option2 = (n % 2) + 1 + solve(n / 2);
    int days_option3 = (n % 3) + 1 + solve(n / 3);

    // Take the minimum of these two optimized paths
    int min_days = (days_option2 < days_option3) ? days_option2 : days_option3;

    // Store result in memoization table before returning
    insertOrUpdateMap(n, min_days);
    return min_days;
}

int minDays(int n) {
    // Clear the hash map if it contains entries from a previous test case.
    if (map_has_entries) {
        clearMap();
    }
    return solve(n);
}