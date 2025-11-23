#include <stdio.h>
#include <stdlib.h>

struct DataFrame {
    int id;
    char *name;
    int age;
};

struct DataFrame* selectData(struct DataFrame* students, int studentsSize) {
    struct DataFrame* result = (struct DataFrame*)malloc(sizeof(struct DataFrame));
    result->id = students[0].id;
    result->name = (char*)malloc(strlen(students[0].name) + 1);
    strcpy(result->name, students[0].name);
    result->age = students[0].age;
    return result;
}