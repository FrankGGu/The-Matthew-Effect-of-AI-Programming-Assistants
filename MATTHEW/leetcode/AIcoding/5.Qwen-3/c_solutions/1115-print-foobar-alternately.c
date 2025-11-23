#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

typedef struct {
    sem_t foo_sem;
    sem_t bar_sem;
} FooBar;

void fooBarInit(FooBar* obj, int n) {
    sem_init(&obj->foo_sem, 0, 1);
    sem_init(&obj->bar_sem, 0, 0);
}

void foo(FooBar* obj, void (*printFoo)(void)) {
    for (int i = 0; i < n; i++) {
        sem_wait(&obj->foo_sem);
        printFoo();
        sem_post(&obj->bar_sem);
    }
}

void bar(FooBar* obj, void (*printBar)(void)) {
    for (int i = 0; i < n; i++) {
        sem_wait(&obj->bar_sem);
        printBar();
        sem_post(&obj->foo_sem);
    }
}