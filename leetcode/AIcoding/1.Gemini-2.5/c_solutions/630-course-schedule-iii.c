#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int duration;
    int lastDay;
} Course;

int compareCourses(const void *a, const void *b) {
    Course *courseA = (Course *)a;
    Course *courseB = (Course *)b;
    return courseA->lastDay - courseB->lastDay;
}

int *heap_arr;
int heap_size;

void heap_init(int capacity) {
    heap_arr = (int *)malloc(sizeof(int) * (capacity + 1));
    heap_size = 0;
}

void heap_free() {
    free(heap_arr);
    heap_arr = NULL;
    heap_size = 0;
}

void heap_push(int val) {
    heap_size++;
    heap_arr[heap_size] = val;
    int current = heap_size;
    while (current > 1 && heap_arr[current / 2] < heap_arr[current]) {
        int temp = heap_arr[current / 2];
        heap_arr[current / 2] = heap_arr[current];
        heap_arr[current] = temp;
        current /= 2;
    }
}

int heap_pop_max() {
    if (heap_size == 0) {
        return -1;
    }
    int maxVal = heap_arr[1];
    heap_arr[1] = heap_arr[heap_size];
    heap_size--;
    int current = 1;
    while (true) {
        int leftChild = 2 * current;
        int rightChild = 2 * current + 1;
        int largest = current;

        if (leftChild <= heap_size && heap_arr[leftChild] > heap_arr[largest]) {
            largest = leftChild;
        }
        if (rightChild <= heap_size && heap_arr[rightChild] > heap_arr[largest]) {
            largest = rightChild;
        }

        if (largest != current) {
            int temp = heap_arr[current];
            heap_arr[current] = heap_arr[largest];
            heap_arr[largest] = temp;
            current = largest;
        } else {
            break;
        }
    }
    return maxVal;
}

int heap_peek_max() {
    if (heap_size == 0) {
        return -1;
    }
    return heap_arr[1];
}

int scheduleCourse(int** courses, int coursesSize, int* coursesColSize) {
    Course *courseList = (Course *)malloc(sizeof(Course) * coursesSize);
    for (int i = 0; i < coursesSize; i++) {
        courseList[i].duration = courses[i][0];
        courseList[i].lastDay = courses[i][1];
    }

    qsort(courseList, coursesSize, sizeof(Course), compareCourses);

    heap_init(coursesSize);

    long long currentTime = 0;
    int numCoursesTaken = 0;

    for (int i = 0; i < coursesSize; i++) {
        int duration = courseList[i].duration;
        int lastDay = courseList[i].lastDay;

        if (currentTime + duration <= lastDay) {
            currentTime += duration;
            heap_push(duration);
            numCoursesTaken++;
        } else if (heap_size > 0 && duration < heap_peek_max()) {
            int maxDurationInHeap = heap_pop_max();
            currentTime -= maxDurationInHeap;

            currentTime += duration;
            heap_push(duration);
        }
    }

    free(courseList);
    heap_free();

    return numCoursesTaken;
}