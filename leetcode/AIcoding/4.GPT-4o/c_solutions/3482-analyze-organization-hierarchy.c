typedef struct {
    int id;
    int importance;
    int *subordinates;
    int subordinatesSize;
} Employee;

int getImportance(Employee* employees, int employeesSize, int id) {
    int totalImportance = 0;
    int *visited = (int *)calloc(employeesSize, sizeof(int));
    int queueSize = 0;
    int *queue = (int *)malloc(employeesSize * sizeof(int));

    queue[queueSize++] = id;

    while (queueSize > 0) {
        int currentId = queue[--queueSize];
        for (int i = 0; i < employeesSize; i++) {
            if (employees[i].id == currentId && !visited[i]) {
                totalImportance += employees[i].importance;
                visited[i] = 1;
                for (int j = 0; j < employees[i].subordinatesSize; j++) {
                    queue[queueSize++] = employees[i].subordinates[j];
                }
                break;
            }
        }
    }

    free(visited);
    free(queue);

    return totalImportance;
}