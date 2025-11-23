#include <pthread.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int n;
    int current_num;
    pthread_mutex_t mtx;
    pthread_cond_t zero_cond;
    pthread_cond_t even_cond;
    pthread_cond_t odd_cond;
    bool zero_turn;
    bool even_turn;
    bool odd_turn;
} ZeroEvenOdd;

ZeroEvenOdd* zeroEvenOddCreate(int n) {
    ZeroEvenOdd* obj = (ZeroEvenOdd*) malloc(sizeof(ZeroEvenOdd));
    obj->n = n;
    obj->current_num = 1;
    pthread_mutex_init(&obj->mtx, NULL);
    pthread_cond_init(&obj->zero_cond, NULL);
    pthread_cond_init(&obj->even_cond, NULL);
    pthread_cond_init(&obj->odd_cond, NULL);
    obj->zero_turn = true;
    obj->even_turn = false;
    obj->odd_turn = false;
    return obj;
}

void zero(ZeroEvenOdd* obj, void (*printNumber)(int)) {
    while (true) {
        pthread_mutex_lock(&obj->mtx);
        while (!obj->zero_turn && obj->current_num <= obj->n) {
            pthread_cond_wait(&obj->zero_cond, &obj->mtx);
        }
        if (obj->current_num > obj->n) {
            pthread_cond_broadcast(&obj->even_cond);
            pthread_cond_broadcast(&obj->odd_cond);
            pthread_mutex_unlock(&obj->mtx);
            break;
        }
        printNumber(0);
        obj->zero_turn = false;
        if (obj->current_num % 2 == 0) {
            obj->even_turn = true;
            pthread_cond_signal(&obj->even_cond);
        } else {
            obj->odd_turn = true;
            pthread_cond_signal(&obj->odd_cond);
        }
        pthread_mutex_unlock(&obj->mtx);
    }
}

void even(ZeroEvenOdd* obj, void (*printNumber)(int)) {
    while (true) {
        pthread_mutex_lock(&obj->mtx);
        while (!obj->even_turn && obj->current_num <= obj->n) {
            pthread_cond_wait(&obj->even_cond, &obj->mtx);
        }
        if (obj->current_num > obj->n) {
            pthread_cond_broadcast(&obj->zero_cond);
            pthread_cond_broadcast(&obj->odd_cond);
            pthread_mutex_unlock(&obj->mtx);
            break;
        }
        printNumber(obj->current_num);
        obj->current_num++;
        obj->even_turn = false;
        obj->zero_turn = true;
        pthread_cond_signal(&obj->zero_cond);
        pthread_mutex_unlock(&obj->mtx);
    }
}

void odd(ZeroEvenOdd* obj, void (*printNumber)(int)) {
    while (true) {
        pthread_mutex_lock(&obj->mtx);
        while (!obj->odd_turn && obj->current_num <= obj->n) {
            pthread_cond_wait(&obj->odd_cond, &obj->mtx);
        }
        if (obj->current_num > obj->n) {
            pthread_cond_broadcast(&obj->zero_cond);
            pthread_cond_broadcast(&obj->even_cond);
            pthread_mutex_unlock(&obj->mtx);
            break;
        }
        printNumber(obj->current_num);
        obj->current_num++;
        obj->odd_turn = false;
        obj->zero_turn = true;
        pthread_cond_signal(&obj->zero_cond);
        pthread_mutex_unlock(&obj->mtx);
    }
}

void zeroEvenOddFree(ZeroEvenOdd* obj) {
    pthread_mutex_destroy(&obj->mtx);
    pthread_cond_destroy(&obj->zero_cond);
    pthread_cond_destroy(&obj->even_cond);
    pthread_cond_destroy(&obj->odd_cond);
    free(obj);
}