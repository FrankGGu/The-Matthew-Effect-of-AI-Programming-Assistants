#include <stdlib.h>

struct Employee {
    int id;
    int importance;
    int num_subordinates;
    int* subordinates;
};

int getImportance(struct Employee* employees, int employeesSize, int id) {
    int* map = (int*)malloc(2001 * sizeof(int));
    for (int i = 0; i < employeesSize; i++) {
        map[employees[i].id] = i;
    }

    int total = 0;
    int* queue = (int*)malloc(employeesSize * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = id;

    while (front < rear) {
        int curr_id = queue[front++];
        int idx = map[curr_id];
        total += employees[idx].importance;

        for (int i = 0; i < employees[idx].num_subordinates; i++) {
            queue[rear++] = employees[idx].subordinates[i];
        }
    }

    free(map);
    free(queue);
    return total;
}