#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    pthread_mutex_t *forks;
    sem_t *room;
} DiningPhilosophers;

DiningPhilosophers* DiningPhilosophersCreate(int n) {
    DiningPhilosophers* obj = (DiningPhilosophers*)malloc(sizeof(DiningPhilosophers));
    obj->forks = (pthread_mutex_t*)malloc(sizeof(pthread_mutex_t) * n);
    obj->room = (sem_t*)malloc(sizeof(sem_t));
    sem_init(obj->room, 0, n - 1);
    for (int i = 0; i < n; i++) {
        pthread_mutex_init(&(obj->forks[i]), NULL);
    }
    return obj;
}

void wantsToEat(DiningPhilosophers* obj, int philosopher,
                  void (*pickLeftFork)(int philosopher),
                  void (*pickRightFork)(int philosopher),
                  void (*eat)(int philosopher),
                  void (*putLeftFork)(int philosopher),
                  void (*putRightFork)(int philosopher)) {
    sem_wait(obj->room);
    pthread_mutex_lock(&(obj->forks[philosopher]));
    pickLeftFork(philosopher);
    pthread_mutex_lock(&(obj->forks[(philosopher + 1) % 5]));
    pickRightFork(philosopher);
    eat(philosopher);
    putLeftFork(philosopher);
    pthread_mutex_unlock(&(obj->forks[philosopher]));
    putRightFork(philosopher);
    pthread_mutex_unlock(&(obj->forks[(philosopher + 1) % 5]));
    sem_post(obj->room);
}

void DiningPhilosophersFree(DiningPhilosophers* obj) {
    for (int i = 0; i < 5; i++) {
        pthread_mutex_destroy(&(obj->forks[i]));
    }
    sem_destroy(obj->room);
    free(obj->forks);
    free(obj->room);
    free(obj);
}