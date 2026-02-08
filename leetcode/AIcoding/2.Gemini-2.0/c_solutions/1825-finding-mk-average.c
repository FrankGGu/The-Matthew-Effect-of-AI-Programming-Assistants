#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int m;
    int k;
    int size;
    int *nums;
    long long sum;
    int count;
    int *data;
    int head;
    int tail;
} MKAverage;

MKAverage* mkAverageCreate(int m, int k) {
    MKAverage* obj = (MKAverage*)malloc(sizeof(MKAverage));
    obj->m = m;
    obj->k = k;
    obj->size = 0;
    obj->nums = (int*)malloc(sizeof(int) * m);
    obj->sum = 0;
    obj->count = 0;
    obj->data = (int*)malloc(sizeof(int) * 100000);
    obj->head = 0;
    obj->tail = 0;
    return obj;
}

void mkAverageAddElement(MKAverage* obj, int num) {
    if (obj->size < obj->m) {
        obj->nums[obj->size++] = num;
    } else {
        for (int i = 0; i < obj->m - 1; i++) {
            obj->nums[i] = obj->nums[i + 1];
        }
        obj->nums[obj->m - 1] = num;
    }
    obj->data[obj->tail++] = num;
    obj->count++;
}

int mkAverageCalculate(MKAverage* obj) {
    if (obj->size < obj->m) {
        return -1;
    }

    int arr[obj->m];
    for (int i = 0; i < obj->m; i++) {
        arr[i] = obj->nums[i];
    }

    for (int i = 0; i < obj->m - 1; i++) {
        for (int j = 0; j < obj->m - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    long long sum = 0;
    for (int i = obj->k; i < obj->m - obj->k; i++) {
        sum += arr[i];
    }

    return (int)(sum / (obj->m - 2 * obj->k));
}

void mkAverageFree(MKAverage* obj) {
    free(obj->nums);
    free(obj->data);
    free(obj);
}