typedef struct {
    int key;
    int value;
    UT_hash_handle hh;
} HashMap;

int minimumSeconds(int* nums, int numsSize) {
    HashMap *map = NULL, *s, *tmp;
    int *arr = (int *)malloc(sizeof(int) * numsSize * 3);
    for (int i = 0; i < numsSize; i++) {
        arr[i] = nums[i];
        arr[i + numsSize] = nums[i];
        arr[i + 2 * numsSize] = nums[i];
    }

    for (int i = 0; i < numsSize * 3; i++) {
        HASH_FIND_INT(map, &arr[i], s);
        if (s == NULL) {
            s = (HashMap *)malloc(sizeof(HashMap));
            s->key = arr[i];
            s->value = i;
            HASH_ADD_INT(map, key, s);
        } else {
            s->value = i;
        }
    }

    int *last = (int *)malloc(sizeof(int) * numsSize * 3);
    for (int i = 0; i < numsSize * 3; i++) {
        last[i] = -1;
    }

    HASH_ITER(hh, map, s, tmp) {
        HASH_DEL(map, s);
        free(s);
    }

    for (int i = 0; i < numsSize * 3; i++) {
        HASH_FIND_INT(map, &arr[i], s);
        if (s == NULL) {
            s = (HashMap *)malloc(sizeof(HashMap));
            s->key = arr[i];
            s->value = i;
            HASH_ADD_INT(map, key, s);
        } else {
            last[i] = s->value;
            s->value = i;
        }
    }

    int *maxGap = (int *)malloc(sizeof(int) * 1000000);
    memset(maxGap, 0, sizeof(int) * 1000000);

    HASH_ITER(hh, map, s, tmp) {
        int key = s->key;
        int pos = s->value;
        int first = -1;
        int prev = -1;
        for (int i = 0; i < numsSize * 3; i++) {
            if (arr[i] == key) {
                if (first == -1) {
                    first = i;
                    prev = i;
                } else {
                    if (i - prev > maxGap[key]) {
                        maxGap[key] = i - prev;
                    }
                    prev = i;
                }
            }
        }
        if (numsSize * 3 - prev + first > maxGap[key]) {
            maxGap[key] = numsSize * 3 - prev + first;
        }
        HASH_DEL(map, s);
        free(s);
    }

    int minSeconds = INT_MAX;
    for (int i = 0; i < 1000000; i++) {
        if (maxGap[i] > 0) {
            int seconds = maxGap[i] / 2;
            if (seconds < minSeconds) {
                minSeconds = seconds;
            }
        }
    }

    free(arr);
    free(last);
    free(maxGap);
    return minSeconds;
}