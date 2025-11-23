#include <stdlib.h>

typedef struct {
    int p;
    int t;
    double gain;
} ClassNode;

ClassNode* heap;
int heap_size;

double calculate_gain(int p, int t) {
    if (t == p) return 0.0;
    return (double)(t - p) / ((double)t * (t + 1));
}

void swap(int i, int j) {
    ClassNode temp = heap[i];
    heap[i] = heap[j];
    heap[j] = temp;
}

void heap_swim(int k) {
    while (k > 0 && heap[k].gain > heap[(k - 1) / 2].gain) {
        swap(k, (k - 1) / 2);
        k = (k - 1) / 2;
    }
}

void heap_sink(int k) {
    while (2 * k + 1 < heap_size) {
        int j = 2 * k + 1;
        if (j + 1 < heap_size && heap[j + 1].gain > heap[j].gain) {
            j++;
        }
        if (heap[k].gain >= heap[j].gain) break;
        swap(k, j);
        k = j;
    }
}

void heap_insert(ClassNode node) {
    heap[heap_size++] = node;
    heap_swim(heap_size - 1);
}

ClassNode heap_extract_max() {
    ClassNode max_node = heap[0];
    heap_size--;
    if (heap_size > 0) {
        heap[0] = heap[heap_size];
        heap_sink(0);
    }
    return max_node;
}

double maxAverageRatio(int** classes, int classesSize, int* classesColSize, int extraStudents) {
    heap = (ClassNode*)malloc(sizeof(ClassNode) * classesSize);
    heap_size = 0;

    for (int i = 0; i < classesSize; i++) {
        ClassNode node;
        node.p = classes[i][0];
        node.t = classes[i][1];
        node.gain = calculate_gain(node.p, node.t);
        heap_insert(node);
    }

    for (int i = 0; i < extraStudents; i++) {
        ClassNode current_max_gain_class = heap_extract_max();

        current_max_gain_class.p++;
        current_max_gain_class.t++;

        current_max_gain_class.gain = calculate_gain(current_max_gain_class.p, current_max_gain_class.t);

        heap_insert(current_max_gain_class);
    }

    double total_pass_ratio = 0.0;
    for (int i = 0; i < heap_size; i++) {
        total_pass_ratio += (double)heap[i].p / heap[i].t;
    }

    free(heap);

    return total_pass_ratio / classesSize;
}