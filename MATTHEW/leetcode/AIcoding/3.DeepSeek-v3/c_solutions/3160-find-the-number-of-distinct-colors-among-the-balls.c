typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashMap;

int* queryResults(int limit, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* res = malloc(queriesSize * sizeof(int));
    HashMap *ballToColor = NULL, *colorCount = NULL;
    int distinct = 0;

    for (int i = 0; i < queriesSize; i++) {
        int ball = queries[i][0];
        int color = queries[i][1];

        HashMap *entry;
        HASH_FIND_INT(ballToColor, &ball, entry);

        if (entry) {
            int oldColor = entry->val;
            if (oldColor == color) {
                res[i] = distinct;
                continue;
            }

            HashMap *colorEntry;
            HASH_FIND_INT(colorCount, &oldColor, colorEntry);
            if (colorEntry) {
                colorEntry->val--;
                if (colorEntry->val == 0) {
                    HASH_DEL(colorCount, colorEntry);
                    free(colorEntry);
                    distinct--;
                }
            }
            entry->val = color;
        } else {
            entry = malloc(sizeof(HashMap));
            entry->key = ball;
            entry->val = color;
            HASH_ADD_INT(ballToColor, key, entry);
        }

        HashMap *colorEntry;
        HASH_FIND_INT(colorCount, &color, colorEntry);
        if (colorEntry) {
            colorEntry->val++;
        } else {
            colorEntry = malloc(sizeof(HashMap));
            colorEntry->key = color;
            colorEntry->val = 1;
            HASH_ADD_INT(colorCount, key, colorEntry);
            distinct++;
        }

        res[i] = distinct;
    }

    HashMap *curr, *tmp;
    HASH_ITER(hh, ballToColor, curr, tmp) {
        HASH_DEL(ballToColor, curr);
        free(curr);
    }
    HASH_ITER(hh, colorCount, curr, tmp) {
        HASH_DEL(colorCount, curr);
        free(curr);
    }

    *returnSize = queriesSize;
    return res;
}