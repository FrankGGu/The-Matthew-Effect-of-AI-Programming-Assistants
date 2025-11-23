typedef struct {
    int* arr;
    int size;
    int* candidates;
    int* counts;
    int* idx;
    int idx_size;
} MajorityChecker;

MajorityChecker* majorityCheckerCreate(int* arr, int arrSize) {
    MajorityChecker* obj = (MajorityChecker*)malloc(sizeof(MajorityChecker));
    obj->arr = arr;
    obj->size = arrSize;

    obj->candidates = (int*)malloc(arrSize * sizeof(int));
    obj->counts = (int*)malloc(arrSize * sizeof(int));
    obj->idx = (int*)malloc(arrSize * sizeof(int));
    obj->idx_size = 0;

    int candidate = -1, count = 0;
    for (int i = 0; i < arrSize; i++) {
        if (count == 0) {
            candidate = arr[i];
            count = 1;
        } else if (arr[i] == candidate) {
            count++;
        } else {
            count--;
        }

        if (count > 0) {
            obj->candidates[i] = candidate;
            obj->counts[i] = count;
        } else {
            obj->candidates[i] = -1;
            obj->counts[i] = 0;
        }

        if (i == 0 || arr[i] != arr[i-1]) {
            obj->idx[obj->idx_size++] = i;
        }
    }

    return obj;
}

int majorityCheckerQuery(MajorityChecker* obj, int left, int right, int threshold) {
    int candidate = -1, count = 0;

    for (int i = left; i <= right; i++) {
        if (count == 0) {
            candidate = obj->arr[i];
            count = 1;
        } else if (obj->arr[i] == candidate) {
            count++;
        } else {
            count--;
        }
    }

    if (candidate != -1) {
        count = 0;
        for (int i = left; i <= right; i++) {
            if (obj->arr[i] == candidate) {
                count++;
            }
        }
        if (count >= threshold) {
            return candidate;
        }
    }

    int low = 0, high = obj->idx_size - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (obj->idx[mid] < left) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    for (int i = low; i < obj->idx_size && obj->idx[i] <= right; i++) {
        int pos = obj->idx[i];
        int num = obj->arr[pos];
        int cnt = 1;

        int j = pos + 1;
        while (j <= right && obj->arr[j] == num) {
            cnt++;
            j++;
        }

        if (cnt >= threshold) {
            return num;
        }

        i += cnt - 1;
    }

    return -1;
}

void majorityCheckerFree(MajorityChecker* obj) {
    free(obj->candidates);
    free(obj->counts);
    free(obj->idx);
    free(obj);
}