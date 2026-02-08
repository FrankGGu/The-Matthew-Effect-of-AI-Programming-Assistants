typedef struct {
    int key;
    int value;
    UT_hash_handle hh;
} HashItem;

int minAreaRect(int** points, int pointsSize, int* pointsColSize) {
    HashItem *map = NULL;
    for (int i = 0; i < pointsSize; i++) {
        int *point = points[i];
        int key = point[0] * 40001 + point[1];
        HashItem *pEntry = NULL;
        HASH_FIND_INT(map, &key, pEntry);
        if (pEntry == NULL) {
            pEntry = (HashItem *)malloc(sizeof(HashItem));
            pEntry->key = key;
            pEntry->value = 1;
            HASH_ADD_INT(map, key, pEntry);
        }
    }

    int minArea = INT_MAX;
    for (int i = 0; i < pointsSize; i++) {
        int *p1 = points[i];
        for (int j = i + 1; j < pointsSize; j++) {
            int *p2 = points[j];
            if (p1[0] != p2[0] && p1[1] != p2[1]) {
                int key1 = p1[0] * 40001 + p2[1];
                int key2 = p2[0] * 40001 + p1[1];
                HashItem *pEntry1 = NULL;
                HashItem *pEntry2 = NULL;
                HASH_FIND_INT(map, &key1, pEntry1);
                HASH_FIND_INT(map, &key2, pEntry2);
                if (pEntry1 != NULL && pEntry2 != NULL) {
                    int area = abs(p1[0] - p2[0]) * abs(p1[1] - p2[1]);
                    if (area < minArea) {
                        minArea = area;
                    }
                }
            }
        }
    }

    HashItem *curr, *tmp;
    HASH_ITER(hh, map, curr, tmp) {
        HASH_DEL(map, curr);
        free(curr);
    }

    return minArea == INT_MAX ? 0 : minArea;
}