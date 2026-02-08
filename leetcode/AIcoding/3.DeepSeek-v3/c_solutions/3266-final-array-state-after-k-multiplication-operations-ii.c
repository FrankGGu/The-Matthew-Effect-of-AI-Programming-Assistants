typedef long long ll;

typedef struct {
    ll val;
    int idx;
} Element;

int cmp(const void* a, const void* b) {
    Element* e1 = (Element*)a;
    Element* e2 = (Element*)b;
    if (e1->val != e2->val) {
        return (e1->val > e2->val) ? 1 : -1;
    }
    return e1->idx - e2->idx;
}

int cmp_int(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int* getFinalState(int* nums, int numsSize, int k, int multiplier, int* returnSize) {
    *returnSize = numsSize;
    if (multiplier == 1) {
        return nums;
    }

    Element* arr = (Element*)malloc(numsSize * sizeof(Element));
    for (int i = 0; i < numsSize; i++) {
        arr[i].val = nums[i];
        arr[i].idx = i;
    }
    qsort(arr, numsSize, sizeof(Element), cmp);

    while (k > 0) {
        ll min_val = arr[0].val;
        int count = 1;
        while (count < numsSize && arr[count].val == min_val) {
            count++;
        }

        if (k < count) {
            break;
        }

        for (int i = 0; i < count; i++) {
            arr[i].val *= multiplier;
        }

        k -= count;

        if (count < numsSize) {
            for (int i = count; i > 0; i--) {
                if (arr[0].val <= arr[i].val) {
                    Element temp = arr[0];
                    arr[0] = arr[i-1];
                    arr[i-1] = temp;
                    break;
                }
            }
        }
    }

    for (int i = 0; i < numsSize; i++) {
        nums[arr[i].idx] = arr[i].val;
    }

    free(arr);
    return nums;
}