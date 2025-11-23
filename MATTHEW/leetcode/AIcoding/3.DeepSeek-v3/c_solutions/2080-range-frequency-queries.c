typedef struct {
    int* arr;
    int arrSize;
    int** indices;
    int* indexSizes;
    int maxVal;
} RangeFreqQuery;

RangeFreqQuery* rangeFreqQueryCreate(int* arr, int arrSize) {
    RangeFreqQuery* obj = (RangeFreqQuery*)malloc(sizeof(RangeFreqQuery));
    obj->arr = arr;
    obj->arrSize = arrSize;

    obj->maxVal = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > obj->maxVal) obj->maxVal = arr[i];
    }

    obj->indices = (int**)malloc((obj->maxVal + 1) * sizeof(int*));
    obj->indexSizes = (int*)calloc(obj->maxVal + 1, sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        obj->indexSizes[arr[i]]++;
    }

    for (int i = 0; i <= obj->maxVal; i++) {
        if (obj->indexSizes[i] > 0) {
            obj->indices[i] = (int*)malloc(obj->indexSizes[i] * sizeof(int));
            obj->indexSizes[i] = 0;
        }
    }

    for (int i = 0; i < arrSize; i++) {
        int val = arr[i];
        obj->indices[val][obj->indexSizes[val]++] = i;
    }

    return obj;
}

int rangeFreqQueryQuery(RangeFreqQuery* obj, int left, int right, int value) {
    if (value > obj->maxVal || obj->indexSizes[value] == 0) return 0;

    int* arr = obj->indices[value];
    int n = obj->indexSizes[value];

    int l = 0, r = n - 1;
    int first = -1;
    while (l <= r) {
        int mid = l + (r - l) / 2;
        if (arr[mid] >= left) {
            first = mid;
            r = mid - 1;
        } else {
            l = mid + 1;
        }
    }

    if (first == -1) return 0;

    l = 0, r = n - 1;
    int last = -1;
    while (l <= r) {
        int mid = l + (r - l) / 2;
        if (arr[mid] <= right) {
            last = mid;
            l = mid + 1;
        } else {
            r = mid - 1;
        }
    }

    if (last == -1) return 0;

    return last - first + 1;
}

void rangeFreqQueryFree(RangeFreqQuery* obj) {
    for (int i = 0; i <= obj->maxVal; i++) {
        if (obj->indexSizes[i] > 0) {
            free(obj->indices[i]);
        }
    }
    free(obj->indices);
    free(obj->indexSizes);
    free(obj);
}