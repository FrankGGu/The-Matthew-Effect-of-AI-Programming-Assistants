#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Employee {
    int id;
    int importance;
    int* subordinates;
    int subordinatesCount;
};

int getImportance(struct Employee* employees, int employeesSize, int id) {
    int totalImportance = 0;
    struct Employee* employeeMap[2001] = {NULL};
    for (int i = 0; i < employeesSize; i++) {
        employeeMap[employees[i].id] = &employees[i];
    }

    struct Employee* currentEmployee = employeeMap[id];
    totalImportance += currentEmployee->importance;

    int* queue = (int*)malloc(sizeof(int) * employeesSize);
    int front = 0, rear = 0;

    for (int i = 0; i < currentEmployee->subordinatesCount; i++) {
        queue[rear++] = currentEmployee->subordinates[i];
    }

    while (front < rear) {
        int currentId = queue[front++];
        struct Employee* subEmployee = employeeMap[currentId];
        totalImportance += subEmployee->importance;
        for (int i = 0; i < subEmployee->subordinatesCount; i++) {
            queue[rear++] = subEmployee->subordinates[i];
        }
    }

    free(queue);
    return totalImportance;
}