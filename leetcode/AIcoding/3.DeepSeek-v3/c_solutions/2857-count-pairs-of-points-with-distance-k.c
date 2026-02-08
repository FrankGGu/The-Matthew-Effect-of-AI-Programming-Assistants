typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashMap;

int countPairs(int** points, int pointsSize, int* pointsColSize, int k) {
    HashMap *map = NULL;
    int res = 0;

    for (int i = 0; i < pointsSize; i++) {
        int x1 = points[i][0], y1 = points[i][1];
        for (int a = 0; a <= k; a++) {
            int b = k - a;
            int x2 = x1 ^ a;
            int y2 = y1 ^ b;

            HashMap *entry;
            int key = x2 * 1000000 + y2;
            HASH_FIND_INT(map, &key, entry);
            if (entry) {
                res += entry->val;
            }
        }

        int key = x1 * 1000000 + y1;
        HashMap *entry;
        HASH_FIND_INT(map, &key, entry);
        if (entry) {
            entry->val++;
        } else {
            entry = malloc(sizeof(HashMap));
            entry->key = key;
            entry->val = 1;
            HASH_ADD_INT(map, key, entry);
        }
    }

    HashMap *curr, *tmp;
    HASH_ITER(hh, map, curr, tmp) {
        HASH_DEL(map, curr);
        free(curr);
    }

    return res;
}