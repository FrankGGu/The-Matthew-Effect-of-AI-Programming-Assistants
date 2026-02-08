#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* name;
    int age;
} Dog;

Dog* dogCreate(char* name, int age) {
    Dog* obj = (Dog*)malloc(sizeof(Dog));
    obj->name = (char*)malloc(strlen(name) + 1);
    strcpy(obj->name, name);
    obj->age = age;
    return obj;
}

void dogFree(Dog* obj) {
    if (obj) {
        free(obj->name);
        free(obj);
    }
}

Dog* dogRename(Dog* obj, char* name) {
    free(obj->name);
    obj->name = (char*)malloc(strlen(name) + 1);
    strcpy(obj->name, name);
    return obj;
}

Dog* dogGrowOlder(Dog* obj) {
    obj->age++;
    return obj;
}

char* dogIntroduce(Dog* obj) {
    char* result = (char*)malloc(100);
    sprintf(result, "This is %s, aged %d.", obj->name, obj->age);
    return result;
}