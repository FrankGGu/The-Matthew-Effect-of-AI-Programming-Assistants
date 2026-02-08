typedef struct {
    long long m, k;
    long long sum;
    int *arr;
    int front, rear, size;
    int *sorted;
    int sorted_size;
    long long mid_sum;
} MKAverage;

MKAverage* mkAverageCreate(int m, int k) {
    MKAverage* obj = (MKAverage*)malloc(sizeof(MKAverage));
    obj->m = m;
    obj->k = k;
    obj->sum = 0;
    obj->arr = (int*)malloc(m * sizeof(int));
    obj->front = 0;
    obj->rear = 0;
    obj->size = 0;
    obj->sorted = (int*)malloc(m * sizeof(int));
    obj->sorted_size = 0;
    obj->mid_sum = 0;
    return obj;
}

void insert_sorted(MKAverage* obj, int val) {
    int left = 0, right = obj->sorted_size - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (obj->sorted[mid] < val) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    for (int i = obj->sorted_size; i > left; i--) {
        obj->sorted[i] = obj->sorted[i-1];
    }
    obj->sorted[left] = val;
    obj->sorted_size++;
}

void remove_sorted(MKAverage* obj, int val) {
    int left = 0, right = obj->sorted_size - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (obj->sorted[mid] < val) {
            left = mid + 1;
        } else if (obj->sorted[mid] > val) {
            right = mid - 1;
        } else {
            for (int i = mid; i < obj->sorted_size - 1; i++) {
                obj->sorted[i] = obj->sorted[i+1];
            }
            obj->sorted_size--;
            return;
        }
    }
}

void updateMidSum(MKAverage* obj) {
    obj->mid_sum = 0;
    for (int i = obj->k; i < obj->m - obj->k; i++) {
        obj->mid_sum += obj->sorted[i];
    }
}

void mkAverageAddElement(MKAverage* obj, int num) {
    if (obj->size == obj->m) {
        int old = obj->arr[obj->front];
        obj->front = (obj->front + 1) % obj->m;
        obj->sum -= old;
        remove_sorted(obj, old);
    }

    obj->arr[obj->rear] = num;
    obj->rear = (obj->rear + 1) % obj->m;
    obj->sum += num;
    if (obj->size < obj->m) obj->size++;

    insert_sorted(obj, num);

    if (obj->size == obj->m) {
        updateMidSum(obj);
    }
}

int mkAverageCalculateMKAverage(MKAverage* obj) {
    if (obj->size < obj->m) return -1;
    return obj->mid_sum / (obj->m - 2 * obj->k);
}

void mkAverageFree(MKAverage* obj) {
    free(obj->arr);
    free(obj->sorted);
    free(obj);
}