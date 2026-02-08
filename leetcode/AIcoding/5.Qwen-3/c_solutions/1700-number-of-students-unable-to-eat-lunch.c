#include <stdio.h>
#include <stdlib.h>

int countStudents(int* students, int studentsSize, int* sandwiches, int sandwichesSize) {
    int* queue = (int*)malloc(studentsSize * sizeof(int));
    int front = 0, rear = 0;
    for (int i = 0; i < studentsSize; i++) {
        queue[rear++] = students[i];
    }

    int sandwichIndex = 0;
    while (sandwichIndex < sandwichesSize) {
        int found = 0;
        for (int i = front; i < rear; i++) {
            if (queue[i] == sandwiches[sandwichIndex]) {
                found = 1;
                front = i + 1;
                break;
            }
        }
        if (!found) break;
        sandwichIndex++;
    }

    int result = rear - front;
    free(queue);
    return result;
}