typedef struct {
    int pass;
    int total;
    double gain;
} Class;

int compare(const void* a, const void* b) {
    Class* classA = (Class*)a;
    Class* classB = (Class*)b;
    if (classA->gain < classB->gain) return 1;
    if (classA->gain > classB->gain) return -1;
    return 0;
}

double maxAverageRatio(int** classes, int classesSize, int* classesColSize, int extraStudents) {
    Class* heap = (Class*)malloc(classesSize * sizeof(Class));
    for (int i = 0; i < classesSize; i++) {
        heap[i].pass = classes[i][0];
        heap[i].total = classes[i][1];
        heap[i].gain = ((double)(heap[i].pass + 1) / (heap[i].total + 1)) - ((double)heap[i].pass / heap[i].total);
    }

    qsort(heap, classesSize, sizeof(Class), compare);

    while (extraStudents--) {
        heap[0].pass++;
        heap[0].total++;
        heap[0].gain = ((double)(heap[0].pass + 1) / (heap[0].total + 1)) - ((double)heap[0].pass / heap[0].total);

        for (int i = 1; i < classesSize; i++) {
            if (heap[i].gain > heap[i-1].gain) {
                Class temp = heap[i];
                heap[i] = heap[i-1];
                heap[i-1] = temp;
            } else {
                break;
            }
        }
    }

    double totalRatio = 0.0;
    for (int i = 0; i < classesSize; i++) {
        totalRatio += (double)heap[i].pass / heap[i].total;
    }

    free(heap);
    return totalRatio / classesSize;
}