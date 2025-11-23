#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    char* str;
    int hash;
} StringHash;

typedef struct {
    StringHash* elements;
    int count;
    int capacity;
} HashSet;

void initHashSet(HashSet* set, int initialCapacity) {
    set->elements = (StringHash*)malloc(sizeof(StringHash) * initialCapacity);
    set->count = 0;
    set->capacity = initialCapacity;
}

int stringHash(const char* s, int len) {
    unsigned int h = 0;
    for (int i = 0; i < len; ++i) {
        h = (h * 31) + s[i];
    }
    return h;
}

bool stringEquals(const char* s1, const char* s2, int len) {
    return strncmp(s1, s2, len) == 0;
}

bool containsHashSet(HashSet* set, const char* s, int len, int hashVal) {
    for (int i = 0; i < set->count; ++i) {
        if (set->elements[i].hash == hashVal && stringEquals(set->elements[i].str, s, len)) {
            return true;
        }
    }
    return false;
}

void addHashSet(HashSet* set, const char* s, int len, int hashVal) {
    if (set->count == set->capacity) {
        set->capacity *= 2;
        set->elements = (StringHash*)realloc(set->elements, sizeof(StringHash) * set->capacity);
    }
    set->elements[set->count].str = (char*)s; // Store pointer to substring in original string
    set->elements[set->count].hash = hashVal;
    set->count++;
}

void removeLastHashSet(HashSet* set) {
    if (set->count > 0) {
        set->count--;
    }
}

int maxUnique = 0;
char* global_s;
int global_n;

void backtrack(int index, int currentUniqueCount, HashSet* seenSubstrings) {
    if (index == global_n) {
        if (currentUniqueCount > maxUnique) {
            maxUnique = currentUniqueCount;
        }
        return;
    }

    if (currentUniqueCount + (global_n - index) <= maxUnique) { // Optimization: Pruning
        return;
    }

    for (int i = index; i < global_n; ++i) {
        int len = i - index + 1;
        int hashVal = stringHash(&global_s[index], len);

        if (!containsHashSet(seenSubstrings, &global_s[index], len, hashVal)) {
            addHashSet(seenSubstrings, &global_s[index], len, hashVal);
            backtrack(i + 1, currentUniqueCount + 1, seenSubstrings);
            removeLastHashSet(seenSubstrings); // Backtrack: remove the last added substring
        }
    }
}

int maxUniqueSplit(char* s) {
    global_s = s;
    global_n = strlen(s);
    maxUnique = 0;

    HashSet seenSubstrings;
    initHashSet(&seenSubstrings, 10); // Initial capacity

    backtrack(0, 0, &seenSubstrings);

    free(seenSubstrings.elements); // Free allocated memory for hash set elements
    return maxUnique;
}