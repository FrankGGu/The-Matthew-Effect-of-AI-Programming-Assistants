#include <semaphore.h>
#include <stdlib.h>

typedef struct {
    sem_t sem2;
    sem_t sem3;
} Foo;

Foo* fooCreate() {
    Foo* obj = (Foo*) malloc(sizeof(Foo));
    sem_init(&obj->sem2, 0, 0); // Initialize sem2 to 0
    sem_init(&obj->sem3, 0, 0); // Initialize sem3 to 0
    return obj;
}

void first(Foo* obj) {
    // printFirst() outputs "first". Do not change or remove this line.
    printFirst();
    sem_post(&obj->sem2); // Signal that first has completed
}

void second(Foo* obj) {
    sem_wait(&obj->sem2); // Wait for first to complete
    // printSecond() outputs "second". Do not change or remove this line.
    printSecond();
    sem_post(&obj->sem3); // Signal that second has completed
}

void third(Foo* obj) {
    sem_wait(&obj->sem3); // Wait for second to complete
    // printThird() outputs "third". Do not change or remove this line.
    printThird();
}

void fooFree(Foo* obj) {
    sem_destroy(&obj->sem2);
    sem_destroy(&obj->sem3);
    free(obj);
}