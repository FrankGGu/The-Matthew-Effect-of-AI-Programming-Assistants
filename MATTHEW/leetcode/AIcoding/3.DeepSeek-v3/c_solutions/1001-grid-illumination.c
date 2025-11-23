typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashMap;

void hashMapAdd(HashMap **map, int key, int val) {
    HashMap *entry;
    HASH_FIND_INT(*map, &key, entry);
    if (entry) {
        entry->val += val;
    } else {
        entry = malloc(sizeof(HashMap));
        entry->key = key;
        entry->val = val;
        HASH_ADD_INT(*map, key, entry);
    }
}

int hashMapGet(HashMap *map, int key) {
    HashMap *entry;
    HASH_FIND_INT(map, &key, entry);
    return entry ? entry->val : 0;
}

void hashMapFree(HashMap **map) {
    HashMap *cur, *tmp;
    HASH_ITER(hh, *map, cur, tmp) {
        HASH_DEL(*map, cur);
        free(cur);
    }
}

int* gridIllumination(int n, int** lamps, int lampsSize, int* lampsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    HashMap *row = NULL, *col = NULL, *diag1 = NULL, *diag2 = NULL;
    HashMap *lampSet = NULL;

    for (int i = 0; i < lampsSize; i++) {
        int x = lamps[i][0], y = lamps[i][1];
        if (hashMapGet(lampSet, x * n + y) == 0) {
            hashMapAdd(&lampSet, x * n + y, 1);
            hashMapAdd(&row, x, 1);
            hashMapAdd(&col, y, 1);
            hashMapAdd(&diag1, x + y, 1);
            hashMapAdd(&diag2, x - y, 1);
        }
    }

    int *res = malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int dirs[9][2] = {{0,0}, {0,1}, {0,-1}, {1,0}, {-1,0}, {1,1}, {1,-1}, {-1,1}, {-1,-1}};

    for (int i = 0; i < queriesSize; i++) {
        int x = queries[i][0], y = queries[i][1];
        if (hashMapGet(row, x) > 0 || hashMapGet(col, y) > 0 || hashMapGet(diag1, x + y) > 0 || hashMapGet(diag2, x - y) > 0) {
            res[i] = 1;
        } else {
            res[i] = 0;
        }

        for (int d = 0; d < 9; d++) {
            int nx = x + dirs[d][0], ny = y + dirs[d][1];
            if (nx >= 0 && nx < n && ny >= 0 && ny < n && hashMapGet(lampSet, nx * n + ny) == 1) {
                hashMapAdd(&lampSet, nx * n + ny, -1);
                hashMapAdd(&row, nx, -1);
                hashMapAdd(&col, ny, -1);
                hashMapAdd(&diag1, nx + ny, -1);
                hashMapAdd(&diag2, nx - ny, -1);
            }
        }
    }

    hashMapFree(&row);
    hashMapFree(&col);
    hashMapFree(&diag1);
    hashMapFree(&diag2);
    hashMapFree(&lampSet);

    return res;
}