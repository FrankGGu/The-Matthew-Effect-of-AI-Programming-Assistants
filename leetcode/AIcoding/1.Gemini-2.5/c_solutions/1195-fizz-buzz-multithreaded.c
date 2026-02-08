#include <stdlib.h>
#include <pthread.h>

typedef struct {
    int n;
    int current_num;
    pthread_mutex_t mutex;
    pthread_cond_t cond;
} FizzBuzz;

FizzBuzz* fizzbuzzCreate(int n) {
    FizzBuzz* obj = (FizzBuzz*) malloc(sizeof(FizzBuzz));
    obj->n = n;
    obj->current_num = 1;
    pthread_mutex_init(&obj->mutex, NULL);
    pthread_cond_init(&obj->cond, NULL);
    return obj;
}

void fizz(FizzBuzz* obj, void (*printFizz)()) {
    pthread_mutex_lock(&obj->mutex);
    while (obj->current_num <= obj->n) {
        if (!(obj->current_num % 3 == 0 && obj->current_num % 5 != 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
            continue;
        }
        printFizz();
        obj->current_num++;
        pthread_cond_broadcast(&obj->cond);
    }
    pthread_cond_broadcast(&obj->cond);
    pthread_mutex_unlock(&obj->mutex);
}

void buzz(FizzBuzz* obj, void (*printBuzz)()) {
    pthread_mutex_lock(&obj->mutex);
    while (obj->current_num <= obj->n) {
        if (!(obj->current_num % 5 == 0 && obj->current_num % 3 != 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
            continue;
        }
        printBuzz();
        obj->current_num++;
        pthread_cond_broadcast(&obj->cond);
    }
    pthread_cond_broadcast(&obj->cond);
    pthread_mutex_unlock(&obj->mutex);
}

void fizzbuzz(FizzBuzz* obj, void (*printFizzBuzz)()) {
    pthread_mutex_lock(&obj->mutex);
    while (obj->current_num <= obj->n) {
        if (!(obj->current_num % 15 == 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
            continue;
        }
        printFizzBuzz();
        obj->current_num++;
        pthread_cond_broadcast(&obj->cond);
    }
    pthread_cond_broadcast(&obj->cond);
    pthread_mutex_unlock(&obj->mutex);
}

void number(FizzBuzz* obj, void (*printNumber)(int)) {
    pthread_mutex_lock(&obj->mutex);
    while (obj->current_num <= obj->n) {
        if (!(obj->current_num % 3 != 0 && obj->current_num % 5 != 0)) {
            pthread_cond_wait(&obj->cond, &obj->mutex);
            continue;
        }
        printNumber(obj->current_num);
        obj->current_num++;
        pthread_cond_broadcast(&obj->cond);
    }
    pthread_cond_broadcast(&obj->cond);
    pthread_mutex_unlock(&obj->mutex);
}

void fizzbuzzFree(FizzBuzz* obj) {
    pthread_mutex_destroy(&obj->mutex);
    pthread_cond_destroy(&obj->cond);
    free(obj);
}