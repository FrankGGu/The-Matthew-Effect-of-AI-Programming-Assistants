typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashMap;

int countGoodPartitions(int* nums, int numsSize) {
    HashMap *lastOccurrence = NULL, *s;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        HASH_FIND_INT(lastOccurrence, &num, s);
        if (s) {
            s->val = i;
        } else {
            s = (HashMap*)malloc(sizeof(HashMap));
            s->key = num;
            s->val = i;
            HASH_ADD_INT(lastOccurrence, key, s);
        }
    }

    int partitions = 0;
    int maxIndex = -1;
    int end = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        HASH_FIND_INT(lastOccurrence, &num, s);
        maxIndex = (s->val > maxIndex) ? s->val : maxIndex;

        if (i == maxIndex) {
            partitions++;
            maxIndex = -1;
        }
    }

    long long result = 1;
    long long mod = 1e9 + 7;
    for (int i = 0; i < partitions - 1; i++) {
        result = (result * 2) % mod;
    }

    HashMap *current, *tmp;
    HASH_ITER(hh, lastOccurrence, current, tmp) {
        HASH_DEL(lastOccurrence, current);
        free(current);
    }

    return result;
}