#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int salary;
    int managerId;
} Employee;

int compare(const void* a, const void* b) {
    return ((Employee*)a)->id - ((Employee*)b)->id;
}

int* analyzeOrganization(int* employeeIds, int employeeIdsSize, int* salaries, int salariesSize, int* managerIds, int managerIdsSize, int* returnSize) {
    int n = employeeIdsSize;
    Employee* employees = (Employee*)malloc(n * sizeof(Employee));

    for (int i = 0; i < n; i++) {
        employees[i].id = employeeIds[i];
        employees[i].salary = salaries[i];
        employees[i].managerId = managerIds[i];
    }

    qsort(employees, n, sizeof(Employee), compare);

    int* result = (int*)malloc(3 * sizeof(int));
    *returnSize = 3;

    int maxSalary = 0;
    int minSalary = 1000000;
    int totalSalary = 0;
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (employees[i].managerId == -1) {
            continue;
        }

        int salary = employees[i].salary;
        maxSalary = (salary > maxSalary) ? salary : maxSalary;
        minSalary = (salary < minSalary) ? salary : minSalary;
        totalSalary += salary;
        count++;
    }

    result[0] = maxSalary;
    result[1] = minSalary;
    result[2] = (count > 0) ? totalSalary / count : 0;

    free(employees);
    return result;
}