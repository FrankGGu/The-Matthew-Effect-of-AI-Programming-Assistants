#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    sem_t firstJobDone;
    sem_t secondJobDone;
} Foo;

Foo* fooCreate() {
    Foo* obj = (Foo*)malloc(sizeof(Foo));
    sem_init(&obj->firstJobDone, 0, 0);
    sem_init(&obj->secondJobDone, 0, 0);
    return obj;
}

void first(Foo* obj, void (*printFirst)()) {
    printFirst();
    sem_post(&obj->firstJobDone);
}

void second(Foo* obj, void (*printSecond)()) {
    sem_wait(&obj->firstJobDone);
    printSecond();
    sem_post(&obj->secondJobDone);
}

void third(Foo* obj, void (*printThird)()) {
    sem_wait(&obj->secondJobDone);
    printThird();
}

void fooFree(Foo* obj) {
    sem_destroy(&obj->firstJobDone);
    sem_destroy(&obj->secondJobDone);
    free(obj);
}