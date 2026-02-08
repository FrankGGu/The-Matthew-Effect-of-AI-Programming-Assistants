#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct {
    pthread_mutex_t* mutex;
    pthread_cond_t* cond;
    int* current;
} print_struct;

void* print_one(void* arg) {
    print_struct* ps = (print_struct*)arg;
    pthread_mutex_lock(ps->mutex);
    while (*ps->current != 1) {
        pthread_cond_wait(ps->cond, ps->mutex);
    }
    printf("one\n");
    (*ps->current)++;
    pthread_cond_broadcast(ps->cond);
    pthread_mutex_unlock(ps->mutex);
    return NULL;
}

void* print_two(void* arg) {
    print_struct* ps = (print_struct*)arg;
    pthread_mutex_lock(ps->mutex);
    while (*ps->current != 2) {
        pthread_cond_wait(ps->cond, ps->mutex);
    }
    printf("two\n");
    (*ps->current)++;
    pthread_cond_broadcast(ps->cond);
    pthread_mutex_unlock(ps->mutex);
    return NULL;
}

void* print_three(void* arg) {
    print_struct* ps = (print_struct*)arg;
    pthread_mutex_lock(ps->mutex);
    while (*ps->current != 3) {
        pthread_cond_wait(ps->cond, ps->mutex);
    }
    printf("three\n");
    (*ps->current)++;
    pthread_cond_broadcast(ps->cond);
    pthread_mutex_unlock(ps->mutex);
    return NULL;
}

void printInOrder() {
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
    int current = 1;

    print_struct ps = {&mutex, &cond, &current};

    pthread_t t1, t2, t3;
    pthread_create(&t1, NULL, print_one, (void*)&ps);
    pthread_create(&t2, NULL, print_two, (void*)&ps);
    pthread_create(&t3, NULL, print_three, (void*)&ps);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);

    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&cond);
}