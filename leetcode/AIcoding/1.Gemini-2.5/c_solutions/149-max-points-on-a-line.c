#include <stdlib.h> // For abs, malloc, free, calloc

typedef struct {
    int dx;
    int dy;
} Slope;

typedef struct HashEntry {
    Slope key;
    int count;
    struct HashEntry *next; // For chaining
} HashEntry;

typedef struct {
    HashEntry **buckets;
    int size; // Number of buckets
} HashTable;

unsigned int hash(Slope s, int table_size) {
    // A simple polynomial rolling hash for two integers
    // Using large prime numbers for multipliers to reduce collisions
    // These large primes help spread out the hash values for dx and dy
    unsigned long long val = (unsigned long long)s.dx * 31415926535 + (unsigned long long)s.dy * 2718281828;
    return (unsigned int)(val % table_size);
}

HashTable* createHashTable(int size) {
    HashTable *ht = (HashTable*)malloc(sizeof(HashTable));
    ht->size = size;
    ht->buckets = (HashEntry**)calloc(size, sizeof(HashEntry*)); // calloc initializes to NULL
    return ht;
}

int findOrInsert(HashTable *ht, Slope s) {
    unsigned int index = hash(s, ht->size);
    HashEntry *current = ht->buckets[index];

    // Search for existing entry
    while (current != NULL) {
        if (current->key.dx == s.dx && current->key.dy == s.dy) {
            current->count++;
            return current->count;
        }
        current = current->next;
    }

    // Not found, create new entry
    HashEntry *newEntry = (HashEntry*)malloc(sizeof(HashEntry));
    newEntry->key = s;
    newEntry->count = 1;
    newEntry->next = ht->buckets[index]; // Add to front of list
    ht->buckets[index] = newEntry;
    return 1;
}

void freeHashTable(HashTable *ht) {
    for (int i = 0; i < ht->size; i++) {
        HashEntry *current = ht->buckets[i];
        while (current != NULL) {
            HashEntry *temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(ht->buckets);
    free(ht);
}

int calculateGcd(int a, int b) {
    // Ensure a and b are non-negative for GCD calculation
    a = abs(a);
    b = abs(b);
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize <= 2) {
        return pointsSize;
    }

    int max_overall = 0;
    // Max N = 300. Max unique slopes from a point is N-1 = 299.
    // Choose a prime number for hash table size, larger than N-1, to minimize collisions.
    // 503 is a prime number.
    int HT_SIZE = 503; 

    for (int i = 0; i < pointsSize; i++) {
        HashTable *ht = createHashTable(HT_SIZE);
        int current_max_for_i = 0; // Max points on a line through points[i] (excluding points[i] and its duplicates)
        int duplicates = 0;        // Count of points identical to points[i]

        for (int j = i + 1; j < pointsSize; j++) {
            int x1 = points[i][0];
            int y1 = points[i][1];
            int x2 = points[j][0];
            int y2 = points[j][1];

            if (x1 == x2 && y1 == y2) {
                duplicates++;
                continue; // Skip identical points for slope calculation
            }

            int dx = x2 - x1;
            int dy = y2 - y1;

            // Normalize slope (dx, dy) to a canonical form
            if (dx == 0) { // Vertical line
                dy = 1; // Standardize to (0, 1)
            } else if (dy == 0) { // Horizontal line
                dx = 1; // Standardize to (1, 0)
            } else {
                int common_divisor = calculateGcd(dx, dy);
                dx /= common_divisor;
                dy /= common_divisor;

                // Ensure a canonical representation: dx is positive, or if dx=0 (already handled), dy is positive.
                if (dx < 0) {
                    dx = -dx;
                    dy = -dy;
                }
            }

            Slope s = {dx, dy};
            int count = findOrInsert(ht, s);
            if (count > current_max_for_i) {
                current_max_for_i = count;
            }
        }

        // The total points on a line passing through points[i] is:
        // current_max_for_i (max points for a specific slope)
        // + duplicates (points identical to points[i])
        // + 1 (for points[i] itself)
        // We update max_overall if this count is greater.
        max_overall = (max_overall > (current_max_for_i + duplicates + 1)) ? max_overall : (current_max_for_i + duplicates + 1);

        freeHashTable(ht);
    }

    return max_overall;
}