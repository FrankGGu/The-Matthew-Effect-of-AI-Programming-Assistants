#define MAX_SIZE 100000

typedef struct {
    int *data;
    int head;
    int tail;
    int count;
} MKAverage;

MKAverage* mkaverageCreate(int m, int k) {
    MKAverage *mk = (MKAverage *)malloc(sizeof(MKAverage));
    mk->data = (int *)malloc(sizeof(int) * m);
    mk->head = 0;
    mk->tail = 0;
    mk->count = 0;
    mk->m = m;
    mk->k = k;
    return mk;
}

void mkaverageAdd(MKAverage* obj, int number) {
    if (obj->count < obj->m) {
        obj->data[obj->tail] = number;
        obj->tail = (obj->tail + 1) % obj->m;
        obj->count++;
    } else {
        obj->data[obj->tail] = number;
        obj->tail = (obj->tail + 1) % obj->m;
        obj->head = (obj->head + 1) % obj->m;
    }
}

int mkaverageCalculateMKAverage(MKAverage* obj) {
    if (obj->count < obj->m) return -1;
    int sum = 0;
    int n = obj->m - 2 * obj->k;
    int i = obj->head;
    for (int j = 0; j < obj->m; j++) {
        if (j < obj->k || j >= obj->m - obj->k) {
            i = (i + 1) % obj->m;
            continue;
        }
        sum += obj->data[i];
        i = (i + 1) % obj->m;
    }
    return sum / n;
}

void mkaverageFree(MKAverage* obj) {
    free(obj->data);
    free(obj);
}