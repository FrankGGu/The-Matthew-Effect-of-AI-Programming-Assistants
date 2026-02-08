#include <semaphore.h>

typedef struct {
    sem_t forks[5];
    sem_t max_diners;
} DiningPhilosophers;

DiningPhilosophers* diningPhilosophersCreate() {
    DiningPhilosophers* obj = (DiningPhilosophers*) malloc(sizeof(DiningPhilosophers));
    for (int i = 0; i < 5; i++) {
        sem_init(&obj->forks[i], 0, 1);
    }
    sem_init(&obj->max_diners, 0, 4);
    return obj;
}

void diningPhilosophersPickupFork(DiningPhilosophers* obj, int philosopher, void (*pickFork)()) {
    pickFork();
}

void diningPhilosophersPutdownFork(DiningPhilosophers* obj, int philosopher, void (*putFork)()) {
    putFork();
}

void diningPhilosophersFree(DiningPhilosophers* obj) {
    for (int i = 0; i < 5; i++) {
        sem_destroy(&obj->forks[i]);
    }
    sem_destroy(&obj->max_diners);
    free(obj);
}

void diningPhilosophersWantToEat(DiningPhilosophers* obj, int philosopher,
                                void (*pickLeftFork)(),
                                void (*pickRightFork)(),
                                void (*eat)(),
                                void (*putLeftFork)(),
                                void (*putRightFork)()) {
    int left = philosopher;
    int right = (philosopher + 1) % 5;

    sem_wait(&obj->max_diners);

    if (philosopher % 2 == 0) {
        sem_wait(&obj->forks[left]);
        sem_wait(&obj->forks[right]);
    } else {
        sem_wait(&obj->forks[right]);
        sem_wait(&obj->forks[left]);
    }

    pickLeftFork();
    pickRightFork();

    eat();

    putLeftFork();
    sem_post(&obj->forks[left]);

    putRightFork();
    sem_post(&obj->forks[right]);

    sem_post(&obj->max_diners);
}