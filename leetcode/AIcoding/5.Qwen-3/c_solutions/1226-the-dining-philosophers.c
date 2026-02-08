#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define NUM_PHILOSOPHERS 5

typedef struct {
    sem_t *left;
    sem_t *right;
} Philosopher;

void* eat(void* arg) {
    Philosopher* p = (Philosopher*)arg;
    sem_wait(p->left);
    sem_wait(p->right);
    printf("Philosopher %d is eating\n", (int)(long)arg);
    usleep(100000);
    sem_post(p->right);
    sem_post(p->left);
    return NULL;
}

void diningPhilosophers(int philosophers, int** forks) {
    pthread_t* threads = (pthread_t*)malloc(philosophers * sizeof(pthread_t));
    Philosopher* phils = (Philosopher*)malloc(philosophers * sizeof(Philosopher));

    for (int i = 0; i < philosophers; i++) {
        phils[i].left = &forks[i][0];
        phils[i].right = &forks[(i + 1) % philosophers][0];
        pthread_create(&threads[i], NULL, eat, (void*)(long)i);
    }

    for (int i = 0; i < philosophers; i++) {
        pthread_join(threads[i], NULL);
    }

    free(threads);
    free(phils);
}