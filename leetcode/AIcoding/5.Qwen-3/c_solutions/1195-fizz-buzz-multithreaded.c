#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

typedef struct {
    int n;
    sem_t* sem1;
    sem_t* sem2;
    sem_t* sem3;
    sem_t* sem4;
} FizzBuzz;

void* fizz(void* arg) {
    FizzBuzz* fb = (FizzBuzz*)arg;
    for (int i = 1; i <= fb->n; i++) {
        if (i % 3 == 0 && i % 5 != 0) {
            sem_wait(fb->sem1);
            printf("fizz\n");
            sem_post(fb->sem2);
        }
    }
    return NULL;
}

void* buzz(void* arg) {
    FizzBuzz* fb = (FizzBuzz*)arg;
    for (int i = 1; i <= fb->n; i++) {
        if (i % 5 == 0 && i % 3 != 0) {
            sem_wait(fb->sem2);
            printf("buzz\n");
            sem_post(fb->sem3);
        }
    }
    return NULL;
}

void* fizzbuzz(void* arg) {
    FizzBuzz* fb = (FizzBuzz*)arg;
    for (int i = 1; i <= fb->n; i++) {
        if (i % 3 == 0 && i % 5 == 0) {
            sem_wait(fb->sem3);
            printf("fizzbuzz\n");
            sem_post(fb->sem4);
        }
    }
    return NULL;
}

void* number(void* arg) {
    FizzBuzz* fb = (FizzBuzz*)arg;
    for (int i = 1; i <= fb->n; i++) {
        if (i % 3 != 0 && i % 5 != 0) {
            sem_wait(fb->sem4);
            printf("%d\n", i);
            sem_post(fb->sem1);
        }
    }
    return NULL;
}

void fizzBuzz(int n) {
    FizzBuzz fb;
    fb.n = n;
    sem_t sem1, sem2, sem3, sem4;
    sem_init(&sem1, 0, 1);
    sem_init(&sem2, 0, 0);
    sem_init(&sem3, 0, 0);
    sem_init(&sem4, 0, 0);
    fb.sem1 = &sem1;
    fb.sem2 = &sem2;
    fb.sem3 = &sem3;
    fb.sem4 = &sem4;

    pthread_t t1, t2, t3, t4;
    pthread_create(&t1, NULL, fizz, &fb);
    pthread_create(&t2, NULL, buzz, &fb);
    pthread_create(&t3, NULL, fizzbuzz, &fb);
    pthread_create(&t4, NULL, number, &fb);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);
    pthread_join(t4, NULL);

    sem_destroy(&sem1);
    sem_destroy(&sem2);
    sem_destroy(&sem3);
    sem_destroy(&sem4);
}