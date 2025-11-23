#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int n;
    sem_t sem_number;
    sem_t sem_fizz;
    sem_t sem_buzz;
    sem_t sem_fizzbuzz;
    int current;
} FizzBuzz;

void* fizz(void* obj) {
    FizzBuzz* fb = (FizzBuzz*)obj;
    while (fb->current <= fb->n) {
        sem_wait(&fb->sem_fizz);
        if (fb->current > fb->n) {
            sem_post(&fb->sem_number);
            sem_post(&fb->sem_buzz);
            sem_post(&fb->sem_fizzbuzz);
            break;
        }
        printf("fizz\n");
        fb->current++;
        sem_post(&fb->sem_number);
    }
    return NULL;
}

void* buzz(void* obj) {
    FizzBuzz* fb = (FizzBuzz*)obj;
    while (fb->current <= fb->n) {
        sem_wait(&fb->sem_buzz);
        if (fb->current > fb->n) {
            sem_post(&fb->sem_number);
            sem_post(&fb->sem_fizz);
            sem_post(&fb->sem_fizzbuzz);
            break;
        }
        printf("buzz\n");
        fb->current++;
        sem_post(&fb->sem_number);
    }
    return NULL;
}

void* fizzbuzz(void* obj) {
    FizzBuzz* fb = (FizzBuzz*)obj;
    while (fb->current <= fb->n) {
        sem_wait(&fb->sem_fizzbuzz);
        if (fb->current > fb->n) {
            sem_post(&fb->sem_number);
            sem_post(&fb->sem_fizz);
            sem_post(&fb->sem_buzz);
            break;
        }
        printf("fizzbuzz\n");
        fb->current++;
        sem_post(&fb->sem_number);
    }
    return NULL;
}

void* number(void* obj) {
    FizzBuzz* fb = (FizzBuzz*)obj;
    while (fb->current <= fb->n) {
        sem_wait(&fb->sem_number);
        if (fb->current > fb->n) {
            sem_post(&fb->sem_fizz);
            sem_post(&fb->sem_buzz);
            sem_post(&fb->sem_fizzbuzz);
            break;
        }
        if (fb->current % 3 != 0 && fb->current % 5 != 0) {
            printf("%d\n", fb->current);
        } else if (fb->current % 3 == 0 && fb->current % 5 != 0) {
            sem_post(&fb->sem_fizz);
            continue;
        } else if (fb->current % 3 != 0 && fb->current % 5 == 0) {
            sem_post(&fb->sem_buzz);
            continue;
        } else {
            sem_post(&fb->sem_fizzbuzz);
            continue;
        }
        fb->current++;
        sem_post(&fb->sem_number);
    }
    return NULL;
}

void fizzBuzz(int n) {
    FizzBuzz fb;
    fb.n = n;
    fb.current = 1;
    sem_init(&fb.sem_number, 0, 1);
    sem_init(&fb.sem_fizz, 0, 0);
    sem_init(&fb.sem_buzz, 0, 0);
    sem_init(&fb.sem_fizzbuzz, 0, 0);

    pthread_t thread_number, thread_fizz, thread_buzz, thread_fizzbuzz;

    pthread_create(&thread_number, NULL, number, &fb);
    pthread_create(&thread_fizz, NULL, fizz, &fb);
    pthread_create(&thread_buzz, NULL, buzz, &fb);
    pthread_create(&thread_fizzbuzz, NULL, fizzbuzz, &fb);

    pthread_join(thread_number, NULL);
    pthread_join(thread_fizz, NULL);
    pthread_join(thread_buzz, NULL);
    pthread_join(thread_fizzbuzz, NULL);

    sem_destroy(&fb.sem_number);
    sem_destroy(&fb.sem_fizz);
    sem_destroy(&fb.sem_buzz);
    sem_destroy(&fb.sem_fizzbuzz);
}