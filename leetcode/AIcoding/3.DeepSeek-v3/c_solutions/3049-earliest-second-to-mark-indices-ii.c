typedef long long ll;

typedef struct {
    int key;
    int val;
    int cnt;
} Node;

typedef struct {
    Node* nodes;
    int capacity;
    int size;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->size = 0;
    map->nodes = (Node*)calloc(capacity, sizeof(Node));
    for (int i = 0; i < capacity; i++) {
        map->nodes[i].key = -1;
    }
    return map;
}

void freeHashMap(HashMap* map) {
    free(map->nodes);
    free(map);
}

int hash(int key, int capacity) {
    return (key % capacity + capacity) % capacity;
}

void put(HashMap* map, int key, int val) {
    int idx = hash(key, map->capacity);
    while (map->nodes[idx].key != -1 && map->nodes[idx].key != key) {
        idx = (idx + 1) % map->capacity;
    }
    if (map->nodes[idx].key == -1) {
        map->nodes[idx].key = key;
        map->nodes[idx].val = val;
        map->nodes[idx].cnt = 1;
        map->size++;
    } else {
        map->nodes[idx].val += val;
        map->nodes[idx].cnt++;
    }
}

int get(HashMap* map, int key) {
    int idx = hash(key, map->capacity);
    while (map->nodes[idx].key != -1) {
        if (map->nodes[idx].key == key) {
            return map->nodes[idx].val;
        }
        idx = (idx + 1) % map->capacity;
    }
    return 0;
}

int getCount(HashMap* map, int key) {
    int idx = hash(key, map->capacity);
    while (map->nodes[idx].key != -1) {
        if (map->nodes[idx].key == key) {
            return map->nodes[idx].cnt;
        }
        idx = (idx + 1) % map->capacity;
    }
    return 0;
}

int earliestSecondToMarkIndices(int* nums, int numsSize, int* changeIndices, int changeIndicesSize) {
    int n = numsSize, m = changeIndicesSize;
    int* last = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i <= n; i++) last[i] = -1;

    for (int i = 0; i < m; i++) {
        last[changeIndices[i]] = i + 1;
    }

    int left = 1, right = m, ans = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;

        HashMap* map = createHashMap(n * 2);
        int marked = 0;
        ll total = 0;
        int extra = 0;

        for (int i = mid - 1; i >= 0; i--) {
            int idx = changeIndices[i];
            if (last[idx] == i + 1 && getCount(map, idx) == 0) {
                put(map, idx, nums[idx - 1]);
                if (nums[idx - 1] == 0) {
                    marked++;
                } else {
                    total += nums[idx - 1];
                    if (total + marked > i + 1) {
                        break;
                    }
                }
            } else {
                extra++;
            }
        }

        if (total + marked <= mid - extra) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }

        freeHashMap(map);
    }

    free(last);
    return ans;
}