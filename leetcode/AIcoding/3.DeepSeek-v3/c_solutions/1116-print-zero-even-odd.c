#include <semaphore.h>
#include <pthread.h>

typedef struct {
    int n;
    sem_t zero_sem;
    sem_t even_sem;
    sem_t odd_sem;
} ZeroEvenOdd;

ZeroEvenOdd* zeroEvenOddCreate(int n) {
    ZeroEvenOdd* obj = (ZeroEvenOdd*) malloc(sizeof(ZeroEvenOdd));
    obj->n = n;
    sem_init(&obj->zero_sem, 0, 1);
    sem_init(&obj->even_sem, 0, 0);
    sem_init(&obj->odd_sem, 0, 0);
    return obj;
}

void zero(ZeroEvenOdd* obj) {
    for (int i = 1; i <= obj->n; i++) {
        sem_wait(&obj->zero_sem);
        printNumber(0);
        if (i % 2 == 1) {
            sem_post(&obj->odd_sem);
        } else {
            sem_post(&obj->even_sem);
        }
    }
}

void even(ZeroEvenOdd* obj) {
    for (int i = 2; i <= obj->n; i += 2) {
        sem_wait(&obj->even_sem);
        printNumber(i);
        sem_post(&obj->zero_sem);
    }
}

void odd(ZeroEvenOdd* obj) {
    for (int i = 1; i <= obj->n; i += 2) {
        sem_wait(&obj->odd_sem);
        printNumber(i);
        sem_post(&obj->zero_sem);
    }
}

void zeroEvenOddFree(ZeroEvenOdd* obj) {
    sem_destroy(&obj->zero_sem);
    sem_destroy(&obj->even_sem);
    sem_destroy(&obj->odd_sem);
    free(obj);
}