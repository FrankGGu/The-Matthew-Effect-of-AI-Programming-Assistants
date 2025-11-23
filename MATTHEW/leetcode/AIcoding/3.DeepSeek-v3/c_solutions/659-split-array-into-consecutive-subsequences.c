typedef struct {
    int key;
    int count;
    UT_hash_handle hh;
} HashElement;

bool isPossible(int* nums, int numsSize) {
    HashElement *freq = NULL, *need = NULL;

    for (int i = 0; i < numsSize; i++) {
        HashElement *el;
        HASH_FIND_INT(freq, &nums[i], el);
        if (el == NULL) {
            el = (HashElement*)malloc(sizeof(HashElement));
            el->key = nums[i];
            el->count = 1;
            HASH_ADD_INT(freq, key, el);
        } else {
            el->count++;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        HashElement *el;
        HASH_FIND_INT(freq, &num, el);
        if (el->count == 0) {
            continue;
        }

        HASH_FIND_INT(need, &num, el);
        if (el != NULL && el->count > 0) {
            el->count--;
            HashElement *nextNeed;
            int nextNum = num + 1;
            HASH_FIND_INT(need, &nextNum, nextNeed);
            if (nextNeed == NULL) {
                nextNeed = (HashElement*)malloc(sizeof(HashElement));
                nextNeed->key = nextNum;
                nextNeed->count = 1;
                HASH_ADD_INT(need, key, nextNeed);
            } else {
                nextNeed->count++;
            }
        } else {
            HashElement *count1, *count2;
            int num1 = num + 1, num2 = num + 2;
            HASH_FIND_INT(freq, &num1, count1);
            HASH_FIND_INT(freq, &num2, count2);

            if (count1 != NULL && count1->count > 0 && count2 != NULL && count2->count > 0) {
                HashElement *el;
                HASH_FIND_INT(freq, &num, el);
                el->count--;
                count1->count--;
                count2->count--;

                HashElement *nextNeed;
                int nextNum = num + 3;
                HASH_FIND_INT(need, &nextNum, nextNeed);
                if (nextNeed == NULL) {
                    nextNeed = (HashElement*)malloc(sizeof(HashElement));
                    nextNeed->key = nextNum;
                    nextNeed->count = 1;
                    HASH_ADD_INT(need, key, nextNeed);
                } else {
                    nextNeed->count++;
                }
            } else {
                HashElement *el, *tmp;
                HASH_ITER(hh, freq, el, tmp) {
                    HASH_DEL(freq, el);
                    free(el);
                }
                HASH_ITER(hh, need, el, tmp) {
                    HASH_DEL(need, el);
                    free(el);
                }
                return false;
            }
        }

        HashElement *elFreq;
        HASH_FIND_INT(freq, &num, elFreq);
        elFreq->count--;
    }

    HashElement *el, *tmp;
    HASH_ITER(hh, freq, el, tmp) {
        HASH_DEL(freq, el);
        free(el);
    }
    HASH_ITER(hh, need, el, tmp) {
        HASH_DEL(need, el);
        free(el);
    }

    return true;
}