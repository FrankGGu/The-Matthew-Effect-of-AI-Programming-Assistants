#include <string.h>
#include <stdbool.h>
#include <stdlib.h> // For malloc, free

bool is_vowel(char c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

long long get_min_x_factor(int k, int N_max_v_sub) {
    if (k == 1) return 1;
    long long res = 1;
    long long temp_k = k; 

    for (long long i = 2; i * i <= temp_k; ++i) {
        if (temp_k % i == 0) {
            int count = 0;
            while (temp_k % i == 0) {
                temp_k /= i;
                count++;
            }
            // For prime factor p^a, we need p^ceil(a/2) in min_x_factor
            for (int j = 0; j < (count + 1) / 2; ++j) {
                // Check for overflow or if res already exceeds N_max_v_sub
                // If res * i would exceed N_max_v_sub, then min_x_factor is too large.
                if (res > N_max_v_sub / i) { 
                    return (long long)N_max_v_sub + 1; // Indicate it's too large
                }
                res *= i;
            }
        }
    }
    if (temp_k > 1) { // remaining temp_k is a prime factor
        // Check for overflow or if res already exceeds N_max_v_sub
        if (res > N_max_v_sub / temp_k) {
            return (long long)N_max_v_sub + 1;
        }
        res *= temp_k;
    }
    return res;
}

struct MapNode {
    int diff;
    int mod_k;
    int count;
    struct MapNode* next;
};

struct HashMap {
    struct MapNode** buckets;
    int size; // Number of buckets
    int N_val; // Max string length, used for hash function to normalize diff
};

unsigned int hash(int diff, int mod_k, int map_size, int N_val) {
    // Diff ranges from -N_val to N_val, so shift it by N_val to make it non-negative
    // The maximum possible value for diff + N_val is N_val + N_val = 2 * N_val.
    // The maximum possible value for mod_k is MOD-1, where MOD <= N_val.
    // The combined key_val: (diff + N_val) * (N_val + 1) + mod_k
    // Max value for (diff + N_val) is 2 * N_val.
    // Max value for (N_val + 1) is N_val + 1.
    // Max value for mod_k is N_val - 1.
    // Max key_val approx (2 * N_val) * (N_val + 1) + (N_val - 1)
    // For N_val = 50000, this is approx 2 * 50000 * 50001 = 5 * 10^9, which fits in long long.
    long long key_val = (long long)(diff + N_val) * (N_val + 1) + mod_k;
    return key_val % map_size;
}

struct HashMap* createHashMap(int size, int N_val) {
    struct HashMap* map = (struct HashMap*)malloc(sizeof(struct HashMap));
    map->size = size;
    map->N_val = N_val;
    map->buckets = (struct MapNode**)calloc(size, sizeof(struct MapNode*)); // calloc initializes to NULL
    return map;
}

int get(struct HashMap* map, int diff, int mod_k) {
    unsigned int index = hash(diff, mod_k, map->size, map->N_val);
    struct MapNode* current = map->buckets[index];
    while (current != NULL) {
        if (current->diff == diff && current->mod_k == mod_k) {
            return current->count;
        }
        current = current->next;
    }
    return 0; // Not found
}

void put(struct HashMap* map, int diff, int mod_k) {
    unsigned int index = hash(diff, mod_k, map->size, map->N_val);
    struct MapNode* current = map->buckets[index];
    while (current != NULL) {
        if (current->diff == diff && current->mod_k == mod_k) {
            current->count++;
            return;
        }
        current = current->next;
    }
    // Key not found, create new node
    struct MapNode* newNode = (struct MapNode*)malloc(sizeof(struct MapNode));
    newNode->diff = diff;
    newNode->mod_k = mod_k;
    newNode->count = 1;
    newNode->next = map->buckets[index]; // Add to front of list
    map->buckets[index] = newNode;
}

void freeHashMap(struct HashMap* map) {
    for (int i = 0; i < map->size; ++i) {
        struct MapNode* current = map->buckets[i];
        while (current != NULL) {
            struct MapNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

long long beautifulSubstrings(char* s, int k) {
    int N = strlen(s);
    int N_max_v_sub = N / 2; // Max possible value for v_sub = (length / 2)

    long long min_x_factor = get_min_x_factor(k, N_max_v_sub);

    // If min_x_factor is greater than N_max_v_sub, it means no v_sub > 0 can be a multiple of min_x_factor.
    // Thus, no beautiful substrings exist.
    if (min_x_factor > N_max_v_sub) {
        return 0;
    }

    // MOD is 2 * min_x_factor. The length L = (j+1 - i) must be a multiple of MOD.
    // This implies (j+1) % MOD == i % MOD.
    long long MOD = 2 * min_x_factor;

    long long ans = 0;
    int vowel_count = 0;
    int consonant_count = 0;

    // A hash map size slightly larger than N to minimize collisions.
    // N can be up to 50000. 50003 is a prime number.
    struct HashMap* map = createHashMap(50003, N); 

    // Initialize for the empty prefix (before index 0)
    // At this point, vowel_count = 0, consonant_count = 0, diff = 0.
    // The "position" is 0, so 0 % MOD = 0.
    put(map, 0, 0); 

    for (int j = 0; j < N; ++j) {
        if (is_vowel(s[j])) {
            vowel_count++;
        } else {
            consonant_count++;
        }

        int current_diff = vowel_count - consonant_count;
        // The "position" for the prefix s[0...j] is (j+1)
        int current_pos_mod_MOD = (j + 1) % (int)MOD; 

        // Add counts of previous prefixes that satisfy the conditions
        ans += get(map, current_diff, current_pos_mod_MOD);

        // Store the current prefix's state
        put(map, current_diff, current_pos_mod_MOD);
    }

    freeHashMap(map);

    return ans;
}