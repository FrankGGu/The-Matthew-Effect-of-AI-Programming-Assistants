int getImportance(struct Employee* employees, int employeesSize, int id) {
    int totalImportance = 0;
    struct Employee* employeeMap[2001] = {NULL};

    for (int i = 0; i < employeesSize; i++) {
        employeeMap[employees[i].id] = &employees[i];
    }

    struct Employee* queue[2001];
    int front = 0, rear = 0;

    queue[rear++] = employeeMap[id];

    while (front < rear) {
        struct Employee* current = queue[front++];
        totalImportance += current->importance;

        for (int i = 0; i < current->subordinates.size(); i++) {
            queue[rear++] = employeeMap[current->subordinates[i]];
        }
    }

    return totalImportance;
}