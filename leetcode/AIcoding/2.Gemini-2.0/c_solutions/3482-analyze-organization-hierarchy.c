#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int employee_id;
    int manager_id;
    int importance;
    int subordinates_count;
    int* subordinates;
} Employee;

int getImportance(Employee* employees, int employeesSize, int id) {
    for (int i = 0; i < employeesSize; i++) {
        if (employees[i].employee_id == id) {
            return employees[i].importance;
        }
    }
    return 0;
}

int dfs(Employee* employees, int employeesSize, int id) {
    int importance = getImportance(employees, employeesSize, id);
    for (int i = 0; i < employeesSize; i++) {
        if (employees[i].employee_id == id) {
            for (int j = 0; j < employees[i].subordinates_count; j++) {
                importance += dfs(employees, employeesSize, employees[i].subordinates[j]);
            }
            break;
        }
    }
    return importance;
}

int getImportanceSum(Employee* employees, int employeesSize, int id) {
    return dfs(employees, employeesSize, id);
}