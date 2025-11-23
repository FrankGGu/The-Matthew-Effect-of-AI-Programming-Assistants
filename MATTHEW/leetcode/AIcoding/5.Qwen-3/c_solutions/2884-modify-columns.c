#include <stdio.h>
#include <stdlib.h>

struct Person {
    char *firstName;
    char *lastName;
    int age;
};

struct Person** modifyColumns(struct Person** people, int peopleSize, int* returnSize) {
    *returnSize = peopleSize;
    struct Person** result = (struct Person**)malloc(peopleSize * sizeof(struct Person*));
    for (int i = 0; i < peopleSize; i++) {
        result[i] = (struct Person*)malloc(sizeof(struct Person));
        result[i]->firstName = people[i]->lastName;
        result[i]->lastName = people[i]->firstName;
        result[i]->age = people[i]->age;
    }
    return result;
}