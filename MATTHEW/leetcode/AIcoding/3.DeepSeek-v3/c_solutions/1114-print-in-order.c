#include <semaphore.h>

typedef struct {
    sem_t firstDone;
    sem_t secondDone;
} Foo;

Foo* fooCreate() {
    Foo* obj = (Foo*) malloc(sizeof(Foo));
    sem_init(&obj->firstDone, 0, 0);
    sem_init(&obj->secondDone, 0, 0);
    return obj;
}

void first(Foo* obj) {
    printFirst();
    sem_post(&obj->firstDone);
}

void second(Foo* obj) {
    sem_wait(&obj->firstDone);
    printSecond();
    sem_post(&obj->secondDone);
}

void third(Foo* obj) {
    sem_wait(&obj->secondDone);
    printThird();
}

void fooFree(Foo* obj) {
    sem_destroy(&obj->firstDone);
    sem_destroy(&obj->secondDone);
    free(obj);
}