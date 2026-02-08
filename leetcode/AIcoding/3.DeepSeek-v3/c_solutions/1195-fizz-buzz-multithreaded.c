#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int n;
    int current;
    pthread_mutex_t mutex;
    pthread_cond_t cond;
} FizzBuzz;

FizzBuzz* fizzBuzzCreate(int n) {
    FizzBuzz* obj = (FizzBuzz*) malloc(sizeof(FizzBuzz));
    obj->n = n;
    obj->current = 1;
    pthread_mutex_init(&obj->mutex, NULL);
    pthread_cond_init(&obj->cond, NULL);
    return obj;
}

void fizzBuzzFree(FizzBuzz* obj) {
    pthread_mutex_destroy(&obj->mutex);
    pthread_cond_destroy(&obj->cond);
    free(obj);
}

void fizz(FizzBuzz* obj, void (*printFizz)()) {
    while (1) {
        pthread_mutex_lock(&obj->mutex);
        while (obj->current <= obj->n && (obj->current % 3 != 0 || obj->current % 5 == 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
        }
        if (obj->current > obj->n) {
            pthread_mutex_unlock(&obj->mutex);
            break;
        }
        printFizz();
        obj->current++;
        pthread_cond_broadcast(&obj->cond);
        pthread_mutex_unlock(&obj->mutex);
    }
}

void buzz(FizzBuzz* obj, void (*printBuzz)()) {
    while (1) {
        pthread_mutex_lock(&obj->mutex);
        while (obj->current <= obj->n && (obj->current % 5 != 0 || obj->current % 3 == 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
        }
        if (obj->current > obj->n) {
            pthread_mutex_unlock(&obj->mutex);
            break;
        }
        printBuzz();
        obj->current++;
        pthread_cond_broadcast(&obj->cond);
        pthread_mutex_unlock(&obj->mutex);
    }
}

void fizzbuzz(FizzBuzz* obj, void (*printFizzBuzz)()) {
    while (1) {
        pthread_mutex_lock(&obj->mutex);
        while (obj->current <= obj->n && (obj->current % 3 != 0 || obj->current % 5 != 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
        }
        if (obj->current > obj->n) {
            pthread_mutex_unlock(&obj->mutex);
            break;
        }
        printFizzBuzz();
        obj->current++;
        pthread_cond_broadcast(&obj->cond);
        pthread_mutex_unlock(&obj->mutex);
    }
}

void number(FizzBuzz* obj, void (*printNumber)(int)) {
    while (1) {
        pthread_mutex_lock(&obj->mutex);
        while (obj->current <= obj->n && (obj->current % 3 == 0 || obj->current % 5 == 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
        }
        if (obj->current > obj->n) {
            pthread_mutex_unlock(&obj->mutex);
            break;
        }
        printNumber(obj->current);
        obj->current++;
        pthread_cond_broadcast(&obj->cond);
        pthread_mutex_unlock(&obj->mutex);
    }
}