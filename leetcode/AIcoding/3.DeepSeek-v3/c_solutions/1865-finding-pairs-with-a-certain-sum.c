typedef struct {
    int* nums1;
    int nums1Size;
    int* nums2;
    int nums2Size;
    int* count;
    int countSize;
} FindSumPairs;

FindSumPairs* findSumPairsCreate(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    FindSumPairs* obj = (FindSumPairs*)malloc(sizeof(FindSumPairs));
    obj->nums1 = nums1;
    obj->nums1Size = nums1Size;
    obj->nums2 = nums2;
    obj->nums2Size = nums2Size;

    obj->countSize = 1000001;
    obj->count = (int*)calloc(obj->countSize, sizeof(int));
    for (int i = 0; i < nums2Size; i++) {
        obj->count[nums2[i]]++;
    }

    return obj;
}

void findSumPairsAdd(FindSumPairs* obj, int index, int val) {
    int oldVal = obj->nums2[index];
    obj->count[oldVal]--;
    obj->nums2[index] += val;
    int newVal = obj->nums2[index];
    obj->count[newVal]++;
}

int findSumPairsCount(FindSumPairs* obj, int tot) {
    int res = 0;
    for (int i = 0; i < obj->nums1Size; i++) {
        int complement = tot - obj->nums1[i];
        if (complement >= 0 && complement < obj->countSize) {
            res += obj->count[complement];
        }
    }
    return res;
}

void findSumPairsFree(FindSumPairs* obj) {
    free(obj->count);
    free(obj);
}