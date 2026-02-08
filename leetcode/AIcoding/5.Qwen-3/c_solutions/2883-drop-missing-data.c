#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char** name;
    int* salary;
    int size;
} DataFrame;

DataFrame* dropMissingData(DataFrame* students) {
    int count = 0;
    for (int i = 0; i < students->size; i++) {
        if (students->name[i] != NULL && students->salary[i] != 0) {
            count++;
        }
    }

    DataFrame* result = (DataFrame*)malloc(sizeof(DataFrame));
    result->name = (char**)malloc(count * sizeof(char*));
    result->salary = (int*)malloc(count * sizeof(int));
    result->size = 0;

    for (int i = 0; i < students->size; i++) {
        if (students->name[i] != NULL && students->salary[i] != 0) {
            result->name[result->size] = strdup(students->name[i]);
            result->salary[result->size] = students->salary[i];
            result->size++;
        }
    }

    return result;
}