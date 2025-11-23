#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int age;
} Person;

void fillMissingData(Person* data, int n) {
    for (int i = 0; i < n; i++) {
        if (data[i].name == NULL) {
            data[i].name = (char*)malloc(10 * sizeof(char));
            strcpy(data[i].name, "Unknown");
        }
    }
}