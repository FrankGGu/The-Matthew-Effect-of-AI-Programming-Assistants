typedef struct {
    int key;
    int freq;
} Freq;

int cmp(const void* a, const void* b) {
    return ((Freq*)b)->freq - ((Freq*)a)->freq;
}

int minimumOperations(int* nums, int numsSize) {
    if (numsSize == 1) return 0;

    Freq even[100001] = {0};
    Freq odd[100001] = {0};

    for (int i = 0; i < 100001; i++) {
        even[i].key = i;
        odd[i].key = i;
    }

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            even[nums[i]].freq++;
        } else {
            odd[nums[i]].freq++;
        }
    }

    qsort(even, 100001, sizeof(Freq), cmp);
    qsort(odd, 100001, sizeof(Freq), cmp);

    int even_max1 = even[0].freq;
    int even_max2 = even[1].freq;
    int odd_max1 = odd[0].freq;
    int odd_max2 = odd[1].freq;

    if (even[0].key != odd[0].key) {
        return numsSize - even_max1 - odd_max1;
    } else {
        int option1 = numsSize - even_max1 - odd_max2;
        int option2 = numsSize - even_max2 - odd_max1;
        return option1 < option2 ? option1 : option2;
    }
}