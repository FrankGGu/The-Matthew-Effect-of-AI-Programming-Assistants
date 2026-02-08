#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int id;
    char name[100];
    double salary;
} Employee;

Employee* changeDataTypes(int* id, char** name, double* salary, int size) {
    Employee* result = (Employee*)malloc(size * sizeof(Employee));
    for (int i = 0; i < size; i++) {
        result[i].id = id[i];
        strcpy(result[i].name, name[i]);
        result[i].salary = salary[i];
    }
    return result;
}