#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

sem_t zeroSem;
sem_t evenSem;
sem_t oddSem;

void* zeroFunc(void* arg);
void* evenFunc(void* arg);
void* oddFunc(void* arg);

void printZeroEvenOdd(int n) {
    pthread_t zeroThread, evenThread, oddThread;
    sem_init(&zeroSem, 0, 1);
    sem_init(&evenSem, 0, 0);
    sem_init(&oddSem, 0, 0);

    pthread_create(&zeroThread, NULL, zeroFunc, &n);
    pthread_create(&evenThread, NULL, evenFunc, &n);
    pthread_create(&oddThread, NULL, oddFunc, &n);

    pthread_join(zeroThread, NULL);
    pthread_join(evenThread, NULL);
    pthread_join(oddThread, NULL);

    sem_destroy(&zeroSem);
    sem_destroy(&evenSem);
    sem_destroy(&oddSem);
}

void* zeroFunc(void* arg) {
    int* n = (int*)arg;
    for (int i = 0; i < *n; i++) {
        sem_wait(&zeroSem);
        printf("0");
        if (i % 2 == 0) {
            sem_post(&oddSem);
        } else {
            sem_post(&evenSem);
        }
    }
    return NULL;
}

void* evenFunc(void* arg) {
    int* n = (int*)arg;
    for (int i = 1; i <= *n; i += 2) {
        sem_wait(&evenSem);
        printf("%d", i);
        sem_post(&zeroSem);
    }
    return NULL;
}

void* oddFunc(void* arg) {
    int* n = (int*)arg;
    for (int i = 2; i <= *n; i += 2) {
        sem_wait(&oddSem);
        printf("%d", i);
        sem_post(&zeroSem);
    }
    return NULL;
}