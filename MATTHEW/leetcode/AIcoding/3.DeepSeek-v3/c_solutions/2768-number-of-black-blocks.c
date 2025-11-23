int* countBlackBlocks(int m, int n, int** coordinates, int coordinatesSize, int* coordinatesColSize, int* returnSize) {
    long long total = (long long)(m - 1) * (n - 1);
    int* result = calloc(5, sizeof(int));
    *returnSize = 5;
    result[0] = total;

    typedef struct {
        long long key;
        int count;
    } HashEntry;

    HashEntry* hash = calloc(100000, sizeof(HashEntry));
    int hashSize = 100000;

    for (int i = 0; i < coordinatesSize; i++) {
        int x = coordinates[i][0];
        int y = coordinates[i][1];

        for (int dx = -1; dx <= 0; dx++) {
            for (int dy = -1; dy <= 0; dy++) {
                int nx = x + dx;
                int ny = y + dy;

                if (nx >= 0 && nx < m - 1 && ny >= 0 && ny < n - 1) {
                    long long key = (long long)nx * 100000 + ny;
                    int idx = key % hashSize;

                    while (hash[idx].key != 0 && hash[idx].key != key) {
                        idx = (idx + 1) % hashSize;
                    }

                    if (hash[idx].key == 0) {
                        hash[idx].key = key;
                        hash[idx].count = 1;
                        result[0]--;
                        result[1]++;
                    } else {
                        hash[idx].count++;
                        result[hash[idx].count - 1]--;
                        result[hash[idx].count]++;
                    }
                }
            }
        }
    }

    free(hash);
    return result;
}