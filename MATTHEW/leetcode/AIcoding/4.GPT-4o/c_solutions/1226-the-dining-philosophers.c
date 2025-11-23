#include <semaphore.h>
#include <pthread.h>

#define PHILOSOPHERS 5

sem_t mutex;
sem_t forks[PHILOSOPHERS];

void init() {
    sem_init(&mutex, 0, 1);
    for (int i = 0; i < PHILOSOPHERS; i++) {
        sem_init(&forks[i], 0, 1);
    }
}

void destroy() {
    sem_destroy(&mutex);
    for (int i = 0; i < PHILOSOPHERS; i++) {
        sem_destroy(&forks[i]);
    }
}

void pick_forks(int philosopher) {
    sem_wait(&mutex);
    sem_wait(&forks[philosopher]);
    sem_wait(&forks[(philosopher + 1) % PHILOSOPHERS]);
    sem_post(&mutex);
}

void put_forks(int philosopher) {
    sem_post(&forks[philosopher]);
    sem_post(&forks[(philosopher + 1) % PHILOSOPHERS]);
}

void* philosopher(void* num) {
    int id = *(int*)num;
    while (1) {
        pick_forks(id);
        // Eating
        put_forks(id);
        // Thinking
    }
}

void diningPhilosophers(void) {
    init();
    pthread_t threads[PHILOSOPHERS];
    int ids[PHILOSOPHERS];

    for (int i = 0; i < PHILOSOPHERS; i++) {
        ids[i] = i;
        pthread_create(&threads[i], NULL, philosopher, &ids[i]);
    }

    for (int i = 0; i < PHILOSOPHERS; i++) {
        pthread_join(threads[i], NULL);
    }

    destroy();
}