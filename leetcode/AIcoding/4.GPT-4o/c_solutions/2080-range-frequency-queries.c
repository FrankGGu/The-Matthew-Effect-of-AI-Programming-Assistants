typedef struct {
    int *arr;
    int **freq;
    int size;
} RangeFreqQuery;

RangeFreqQuery* rangeFreqQueryCreate(int* arr, int arrSize) {
    RangeFreqQuery* obj = (RangeFreqQuery*)malloc(sizeof(RangeFreqQuery));
    obj->arr = arr;
    obj->size = arrSize;
    obj->freq = (int**)malloc(sizeof(int*) * (arrSize + 1));
    for (int i = 0; i <= arrSize; i++) {
        obj->freq[i] = (int*)calloc(100001, sizeof(int));
    }
    for (int i = 0; i < arrSize; i++) {
        for (int j = i; j < arrSize; j++) {
            obj->freq[arr[j]][i]++;
        }
    }
    return obj;
}

int rangeFreqQuery(RangeFreqQuery* obj, int left, int right, int value) {
    if (left == 0) {
        return obj->freq[value][right];
    }
    return obj->freq[value][right] - obj->freq[value][left - 1];
}

void rangeFreqQueryFree(RangeFreqQuery* obj) {
    for (int i = 0; i <= obj->size; i++) {
        free(obj->freq[i]);
    }
    free(obj->freq);
    free(obj);
}