#include <stdio.h>
#include <stdlib.h>

struct Employee {
    int id;
    char name[100];
    int salary;
};

struct Employee* getFirstThreeEmployees() {
    struct Employee* result = (struct Employee*)malloc(3 * sizeof(struct Employee));
    if (!result) return NULL;

    result[0].id = 1;
    strcpy(result[0].name, "John");
    result[0].salary = 100000;

    result[1].id = 2;
    strcpy(result[1].name, "Alice");
    result[1].salary = 120000;

    result[2].id = 3;
    strcpy(result[2].name, "Bob");
    result[2].salary = 150000;

    return result;
}