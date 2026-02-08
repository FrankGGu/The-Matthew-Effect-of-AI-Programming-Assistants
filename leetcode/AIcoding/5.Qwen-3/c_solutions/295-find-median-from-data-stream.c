#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* left;
    int left_size;
    int left_capacity;
    int* right;
    int right_size;
    int right_capacity;
} MedianFinder;

MedianFinder* medianFinderCreate() {
    MedianFinder* obj = (MedianFinder*)malloc(sizeof(MedianFinder));
    obj->left = (int*)malloc(sizeof(int) * 1000);
    obj->left_size = 0;
    obj->left_capacity = 1000;
    obj->right = (int*)malloc(sizeof(int) * 1000);
    obj->right_size = 0;
    obj->right_capacity = 1000;
    return obj;
}

void addNum(MedianFinder* obj, int num) {
    if (obj->left_size == 0 || num <= obj->left[0]) {
        if (obj->left_size == obj->left_capacity) {
            obj->left_capacity *= 2;
            obj->left = (int*)realloc(obj->left, sizeof(int) * obj->left_capacity);
        }
        obj->left[obj->left_size++] = num;
        for (int i = obj->left_size - 1; i > 0 && obj->left[i] > obj->left[i - 1]; i--) {
            int temp = obj->left[i];
            obj->left[i] = obj->left[i - 1];
            obj->left[i - 1] = temp;
        }
    } else {
        if (obj->right_size == obj->right_capacity) {
            obj->right_capacity *= 2;
            obj->right = (int*)realloc(obj->right, sizeof(int) * obj->right_capacity);
        }
        obj->right[obj->right_size++] = num;
        for (int i = obj->right_size - 1; i > 0 && obj->right[i] < obj->right[i - 1]; i--) {
            int temp = obj->right[i];
            obj->right[i] = obj->right[i - 1];
            obj->right[i - 1] = temp;
        }
    }

    if (obj->left_size > obj->right_size + 1) {
        int val = obj->left[obj->left_size - 1];
        obj->left_size--;
        obj->right[obj->right_size++] = val;
        for (int i = obj->right_size - 1; i > 0 && obj->right[i] < obj->right[i - 1]; i--) {
            int temp = obj->right[i];
            obj->right[i] = obj->right[i - 1];
            obj->right[i - 1] = temp;
        }
    } else if (obj->right_size > obj->left_size) {
        int val = obj->right[0];
        for (int i = 0; i < obj->right_size - 1; i++) {
            obj->right[i] = obj->right[i + 1];
        }
        obj->right_size--;
        obj->left[obj->left_size++] = val;
        for (int i = obj->left_size - 1; i > 0 && obj->left[i] > obj->left[i - 1]; i--) {
            int temp = obj->left[i];
            obj->left[i] = obj->left[i - 1];
            obj->left[i - 1] = temp;
        }
    }
}

double findMedian(MedianFinder* obj) {
    if ((obj->left_size + obj->right_size) % 2 == 0) {
        return (obj->left[obj->left_size - 1] + obj->right[0]) / 2.0;
    } else {
        return obj->left[obj->left_size - 1];
    }
}

void medianFinderFree(MedianFinder* obj) {
    free(obj->left);
    free(obj->right);
    free(obj);
}