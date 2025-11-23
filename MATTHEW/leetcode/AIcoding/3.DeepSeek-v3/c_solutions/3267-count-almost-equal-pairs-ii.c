#include <stdlib.h>
#include <string.h>

typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashMap;

int countPairs(int* nums, int numsSize) {
    HashMap *map = NULL;
    int res = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int temp = num;
        int digits[10] = {0};
        int len = 0;

        while (temp > 0) {
            digits[len++] = temp % 10;
            temp /= 10;
        }

        for (int mask = 1; mask < (1 << len); mask++) {
            if ((mask & (mask - 1)) == 0) continue;

            int newNum = 0;
            int mult = 1;
            int valid = 1;

            for (int j = 0; j < len; j++) {
                if (mask & (1 << j)) {
                    newNum += digits[j] * mult;
                    mult *= 10;
                }
            }

            if (newNum == 0) continue;

            HashMap *entry;
            HASH_FIND_INT(map, &newNum, entry);
            if (entry) {
                res += entry->val;
            }
        }

        HashMap *entry;
        HASH_FIND_INT(map, &num, entry);
        if (entry) {
            entry->val++;
        } else {
            entry = (HashMap*)malloc(sizeof(HashMap));
            entry->key = num;
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