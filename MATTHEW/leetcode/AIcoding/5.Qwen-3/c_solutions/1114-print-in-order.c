#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

typedef struct {
    sem_t first_done;
    sem_t second_done;
} Foo;

void foo_init(Foo* obj) {
    sem_init(&obj->first_done, 0, 0);
    sem_init(&obj->second_done, 0, 0);
}

void first(Foo* obj) {
    printf("first\n");
    sem_post(&obj->first_done);
}

void second(Foo* obj) {
    sem_wait(&obj->first_done);
    printf("second\n");
    sem_post(&obj->second_done);
}

void third(Foo* obj) {
    sem_wait(&obj->second_done);
    printf("third\n");
}