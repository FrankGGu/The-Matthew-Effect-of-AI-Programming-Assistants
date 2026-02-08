typedef struct {
    long long* segTree;
    long long* segTreeSum;
    int n;
} BookMyShow;

BookMyShow* bookMyShowCreate(int n, int m) {
    BookMyShow* obj = (BookMyShow*)malloc(sizeof(BookMyShow));
    obj->n = n;
    int size = 1;
    while (size < n) size *= 2;
    obj->segTree = (long long*)calloc(2 * size, sizeof(long long));
    obj->segTreeSum = (long long*)calloc(2 * size, sizeof(long long));
    for (int i = 0; i < n; i++) {
        obj->segTree[size + i] = m;
        obj->segTreeSum[size + i] = m;
    }
    for (int i = size - 1; i > 0; i--) {
        obj->segTree[i] = (obj->segTree[2 * i] > obj->segTree[2 * i + 1]) ? obj->segTree[2 * i] : obj->segTree[2 * i + 1];
        obj->segTreeSum[i] = obj->segTreeSum[2 * i] + obj->segTreeSum[2 * i + 1];
    }
    return obj;
}

int* bookMyShowGather(BookMyShow* obj, int k, int maxRow, int* retSize) {
    int size = 1;
    while (size < obj->n) size *= 2;
    if (obj->segTree[1] < k) {
        *retSize = 0;
        return NULL;
    }
    int idx = 1;
    while (idx < size) {
        if (obj->segTree[2 * idx] >= k) {
            idx = 2 * idx;
        } else {
            idx = 2 * idx + 1;
        }
    }
    int row = idx - size;
    if (row > maxRow) {
        *retSize = 0;
        return NULL;
    }
    int seats = obj->segTree[idx];
    int* res = (int*)malloc(2 * sizeof(int));
    res[0] = row;
    res[1] = obj->segTree[idx] - seats;
    obj->segTree[idx] = seats - k;
    obj->segTreeSum[idx] = seats - k;
    idx /= 2;
    while (idx) {
        obj->segTree[idx] = (obj->segTree[2 * idx] > obj->segTree[2 * idx + 1]) ? obj->segTree[2 * idx] : obj->segTree[2 * idx + 1];
        obj->segTreeSum[idx] = obj->segTreeSum[2 * idx] + obj->segTreeSum[2 * idx + 1];
        idx /= 2;
    }
    *retSize = 2;
    return res;
}

bool bookMyShowScatter(BookMyShow* obj, int k, int maxRow) {
    int size = 1;
    while (size < obj->n) size *= 2;
    long long total = 0;
    int idx = size;
    for (int i = 0; i <= maxRow && i < obj->n; i++) {
        total += obj->segTreeSum[idx + i];
        if (total >= k) break;
    }
    if (total < k) return false;
    idx = size;
    for (int i = 0; i <= maxRow && k > 0; i++) {
        int available = obj->segTreeSum[idx + i];
        if (available > 0) {
            int take = (available > k) ? k : available;
            obj->segTreeSum[idx + i] -= take;
            obj->segTree[idx + i] -= take;
            k -= take;
            int pos = (idx + i) / 2;
            while (pos) {
                obj->segTree[pos] = (obj->segTree[2 * pos] > obj->segTree[2 * pos + 1]) ? obj->segTree[2 * pos] : obj->segTree[2 * pos + 1];
                obj->segTreeSum[pos] = obj->segTreeSum[2 * pos] + obj->segTreeSum[2 * pos + 1];
                pos /= 2;
            }
        }
    }
    return true;
}

void bookMyShowFree(BookMyShow* obj) {
    free(obj->segTree);
    free(obj->segTreeSum);
    free(obj);
}