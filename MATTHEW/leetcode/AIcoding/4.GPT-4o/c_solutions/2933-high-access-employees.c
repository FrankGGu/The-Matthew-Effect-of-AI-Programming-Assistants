#include <stdio.h>
#include <stdlib.h>

struct Employee {
    int id;
    int importance;
    int *subordinates;
    int subordinatesSize;
};

int getImportance(struct Employee* employees, int employeesSize, int id) {
    int importance = 0;
    int* queue = (int*)malloc(employeesSize * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < employeesSize; i++) {
        if (employees[i].id == id) {
            queue[rear++] = i;
            break;
        }
    }

    while (front < rear) {
        int curr = queue[front++];
        importance += employees[curr].importance;

        for (int j = 0; j < employees[curr].subordinatesSize; j++) {
            for (int i = 0; i < employeesSize; i++) {
                if (employees[i].id == employees[curr].subordinates[j]) {
                    queue[rear++] = i;
                    break;
                }
            }
        }
    }

    free(queue);
    return importance;
}