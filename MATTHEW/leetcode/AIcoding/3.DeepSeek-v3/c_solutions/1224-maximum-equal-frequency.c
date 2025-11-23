typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashEntry;

int maxEqualFreq(int* nums, int numsSize) {
    HashEntry *freqMap = NULL, *countMap = NULL;
    int maxFreq = 0, res = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        HashEntry *entry;
        HASH_FIND_INT(freqMap, &num, entry);
        int oldFreq = 0;
        if (entry) {
            oldFreq = entry->val;
            HashEntry *countEntry;
            HASH_FIND_INT(countMap, &oldFreq, countEntry);
            if (countEntry) {
                countEntry->val--;
                if (countEntry->val == 0) {
                    HASH_DEL(countMap, countEntry);
                    free(countEntry);
                }
            }
            entry->val++;
        } else {
            entry = malloc(sizeof(HashEntry));
            entry->key = num;
            entry->val = 1;
            HASH_ADD_INT(freqMap, key, entry);
        }
        int newFreq = entry->val;

        HashEntry *newCountEntry;
        HASH_FIND_INT(countMap, &newFreq, newCountEntry);
        if (newCountEntry) {
            newCountEntry->val++;
        } else {
            newCountEntry = malloc(sizeof(HashEntry));
            newCountEntry->key = newFreq;
            newCountEntry->val = 1;
            HASH_ADD_INT(countMap, key, newCountEntry);
        }

        if (newFreq > maxFreq) {
            maxFreq = newFreq;
        }

        int size = HASH_COUNT(countMap);
        if (size == 1) {
            int onlyFreq = ((HashEntry*)countMap)->key;
            if (onlyFreq == 1 || ((HashEntry*)countMap)->val == 1) {
                res = i + 1;
            }
        } else if (size == 2) {
            HashEntry *el1 = countMap;
            HashEntry *el2 = el1->hh.next;
            int freq1 = el1->key, count1 = el1->val;
            int freq2 = el2->key, count2 = el2->val;
            if ((freq1 == 1 && count1 == 1) || (freq2 == 1 && count2 == 1)) {
                res = i + 1;
            } else if ((freq1 == maxFreq && count1 == 1 && freq2 == maxFreq - 1) ||
                       (freq2 == maxFreq && count2 == 1 && freq1 == maxFreq - 1)) {
                res = i + 1;
            }
        }
    }

    HashEntry *current, *tmp;
    HASH_ITER(hh, freqMap, current, tmp) {
        HASH_DEL(freqMap, current);
        free(current);
    }
    HASH_ITER(hh, countMap, current, tmp) {
        HASH_DEL(countMap, current);
        free(current);
    }

    return res;
}