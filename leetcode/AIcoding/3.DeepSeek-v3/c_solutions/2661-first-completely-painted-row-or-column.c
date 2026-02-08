typedef struct {
    int key;
    int row;
    int col;
    UT_hash_handle hh;
} HashEntry;

int firstCompleteIndex(int* arr, int arrSize, int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];

    HashEntry *map = NULL;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            HashEntry *entry = (HashEntry*)malloc(sizeof(HashEntry));
            entry->key = mat[i][j];
            entry->row = i;
            entry->col = j;
            HASH_ADD_INT(map, key, entry);
        }
    }

    int *rowCount = (int*)calloc(m, sizeof(int));
    int *colCount = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        HashEntry *entry;
        HASH_FIND_INT(map, &arr[i], entry);
        if (entry) {
            int r = entry->row;
            int c = entry->col;

            rowCount[r]++;
            colCount[c]++;

            if (rowCount[r] == n || colCount[c] == m) {
                free(rowCount);
                free(colCount);

                HashEntry *current, *tmp;
                HASH_ITER(hh, map, current, tmp) {
                    HASH_DEL(map, current);
                    free(current);
                }
                return i;
            }
        }
    }

    free(rowCount);
    free(colCount);

    HashEntry *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current);
    }

    return -1;
}