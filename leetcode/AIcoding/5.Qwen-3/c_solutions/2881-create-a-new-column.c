#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** employees;
    int employeesSize;
} Employees;

char* createNewColumn(Employees* employees) {
    int n = employees->employeesSize;
    char* result = (char*)malloc((n + 1) * sizeof(char));
    for (int i = 0; i < n; i++) {
        result[i] = employees->employees[i][0];
    }
    result[n] = '\0';
    return result;
}