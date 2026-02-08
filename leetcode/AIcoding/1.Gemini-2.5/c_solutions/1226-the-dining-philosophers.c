#include <pthread.h>
#include <stdlib.h> // For malloc/free

typedef struct {
    pthread_mutex_t forks[5];
} DiningPhilosophers;

DiningPhilosophers* diningPhilosophersCreate() {
    DiningPhilosophers* obj = (DiningPhilosophers*) malloc(sizeof(DiningPhilosophers));
    for (int i = 0; i < 5; ++i) {
        pthread_mutex_init(&obj->forks[i], NULL);
    }
    return obj;
}

void forkAndEat(DiningPhilosophers* obj, int philosopher,
                void (*pickLeftFork)(void),
                void (*pickRightFork)(void),
                void (*eat)(void),
                void (*putLeftFork)(void),
                void (*putRightFork)(void)) {

    int left_fork_idx = philosopher;
    int right_fork_idx = (philosopher + 1) % 5;

    if (philosopher == 4) {
        pthread_mutex_lock(&obj->forks[right_fork_idx]);
        pickRightFork();
        pthread_mutex_lock(&obj->forks[left_fork_idx]);
        pickLeftFork();
    } else {
        pthread_mutex_lock(&obj->forks[left_fork_idx]);
        pickLeftFork();
        pthread_mutex_lock(&obj->forks[right_fork_idx]);
        pickRightFork();
    }

    eat();

    if (philosopher == 4) {
        putLeftFork();
        pthread_mutex_unlock(&obj->forks[left_fork_idx]);
        putRightFork();
        pthread_mutex_unlock(&obj->forks[right_fork_idx]);
    } else {
        putRightFork();
        pthread_mutex_unlock(&obj->forks[right_fork_idx]);
        putLeftFork();
        pthread_mutex_unlock(&obj->forks[left_fork_idx]);
    }
}

void diningPhilosophersFree(DiningPhilosophers* obj) {
    for (int i = 0; i < 5; ++i) {
        pthread_mutex_destroy(&obj->forks[i]);
    }
    free(obj);
}