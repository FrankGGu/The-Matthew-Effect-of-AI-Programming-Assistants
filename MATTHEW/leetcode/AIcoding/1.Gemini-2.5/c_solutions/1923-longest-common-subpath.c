#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define P1 100003LL
#define M1 1000000007LL
#define P2 100019LL
#define M2 1000000009LL

typedef struct {
    long long h1;
    long long h2;
} HashPair;

int compareHashPairs(const void *a, const void *b) {
    HashPair *hpA = (HashPair *)a;
    HashPair *hpB = (HashPair *)b;
    if (hpA->h1 != hpB->h1) {
        return (hpA->h1 < hpB->h1) ? -1 : 1;
    }
    if (hpA->h2 != hpB->h2) {
        return (hpA->h2 < hpB->h2) ? -1 : 1;
    }
    return 0;
}

long long *pow_p1 = NULL;
long long *pow_p2 = NULL;
int max_len_precomputed = 0;

void precompute_powers(int max_len) {
    if (max_len <= max_len_precomputed) return;

    if (pow_p1) free(pow_p1);
    if (pow_p2) free(pow_p2);

    pow_p1 = (long long *)malloc((max_len + 1) * sizeof(long long));
    pow_p2 = (long long *)malloc((max_len + 1) * sizeof(long long));

    pow_p1[0] = 1;
    pow_p2[0] = 1;
    for (int i = 1; i <= max_len; ++i) {
        pow_p1[i] = (pow_p1[i-1] * P1) % M1;
        pow_p2[i] = (pow_p2[i-1] * P2) % M2;
    }
    max_len_precomputed = max_len;
}

bool check(int len, int** paths, int pathsSize, int* pathsColSize) {
    if (len == 0) return true;

    HashPair *common_hashes = NULL;
    int common_hashes_count = 0;

    for (int i = 0; i < pathsSize; ++i) {
        int path_len = pathsColSize[i];
        if (path_len < len) {
            if (i == 0) { // First path is too short
                if (common_hashes) free(common_hashes);
                return false;
            }
            // If subsequent path is too short, and there were common hashes,
            // then no common subpath of this length can exist.
            if (common_hashes_count > 0) {
                if (common_hashes) free(common_hashes);
                return false;
            }
            // If common_hashes_count is already 0, it means no common subpath was found earlier,
            // so we can just return false. This case is implicitly handled by the return false below
            // if common_hashes_count remains 0 after an iteration.
        }

        int current_path_hashes_capacity = path_len - len + 1;
        HashPair *current_path_hashes = (HashPair *)malloc(sizeof(HashPair) * current_path_hashes_capacity);
        int current_path_hashes_count = 0;

        if (current_path_hashes_capacity > 0) {
            long long current_h1 = 0;
            long long current_h2 = 0;

            // Calculate hash for the first subpath of length 'len'
            for (int j = 0; j < len; ++j) {
                current_h1 = (current_h1 * P1 + paths[i][j]) % M1;
                current_h2 = (current_h2 * P2 + paths[i][j]) % M2;
            }
            current_path_hashes[current_path_hashes_count++] = (HashPair){current_h1, current_h2};

            // Calculate rolling hashes for subsequent subpaths
            for (int j = len; j < path_len; ++j) {
                current_h1 = (current_h1 - (paths[i][j - len] * pow_p1[len]) % M1 + M1) % M1;
                current_h1 = (current_h1 * P1 + paths[i][j]) % M1;

                current_h2 = (current_h2 - (paths[i][j - len] * pow_p2[len]) % M2 + M2) % M2;
                current_h2 = (current_h2 * P2 + paths[i][j]) % M2;
                current_path_hashes[current_path_hashes_count++] = (HashPair){current_h1, current_h2};
            }
        }

        // Sort and unique current_path_hashes
        qsort(current_path_hashes, current_path_hashes_count, sizeof(HashPair), compareHashPairs);
        int unique_count = 0;
        if (current_path_hashes_count > 0) {
            current_path_hashes[unique_count++] = current_path_hashes[0];
            for (int j = 1; j < current_path_hashes_count; ++j) {
                if (compareHashPairs(&current_path_hashes[j], &current_path_hashes[j-1]) != 0) {
                    current_path_hashes[unique_count++] = current_path_hashes[j];
                }
            }
        }
        current_path_hashes_count = unique_count;

        if (i == 0) {
            // First path, initialize common_hashes
            common_hashes = current_path_hashes;
            common_hashes_count = current_path_hashes_count;
        } else {
            // Intersect common_hashes with current_path_hashes
            HashPair *next_common_hashes = (HashPair *)malloc(sizeof(HashPair) * (common_hashes_count < current_path_hashes_count ? common_hashes_count : current_path_hashes_count));
            int next_common_hashes_count = 0;
            int ptr1 = 0, ptr2 = 0;
            while (ptr1 < common_hashes_count && ptr2 < current_path_hashes_count) {
                int cmp = compareHashPairs(&common_hashes[ptr1], &current_path_hashes[ptr2]);
                if (cmp == 0) {
                    next_common_hashes[next_common_hashes_count++] = common_hashes[ptr1];
                    ptr1++;
                    ptr2++;
                } else if (cmp < 0) {
                    ptr1++;
                } else {
                    ptr2++;
                }
            }
            free(common_hashes);
            free(current_path_hashes);
            common_hashes = next_common_hashes;
            common_hashes_count = next_common_hashes_count;
        }

        if (common_hashes_count == 0) {
            if (common_hashes) free(common_hashes);
            return false;
        }
    }

    if (common_hashes) free(common_hashes);
    return common_hashes_count > 0;
}

int longestCommonSubpath(int** paths, int pathsSize, int* pathsColSize) {
    int min_path_len = pathsColSize[0];
    for (int i = 1; i < pathsSize; ++i) {
        if (pathsColSize[i] < min_path_len) {
            min_path_len = pathsColSize[i];
        }
    }

    precompute_powers(min_path_len + 1);

    int low = 0, high = min_path_len;
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, paths, pathsSize, pathsColSize)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    if (pow_p1) {
        free(pow_p1);
        pow_p1 = NULL;
    }
    if (pow_p2) {
        free(pow_p2);
        pow_p2 = NULL;
    }
    max_len_precomputed = 0;

    return ans;
}