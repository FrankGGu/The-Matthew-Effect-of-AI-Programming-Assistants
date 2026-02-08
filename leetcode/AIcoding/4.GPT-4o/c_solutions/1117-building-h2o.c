#include <semaphore.h>
#include <pthread.h>

sem_t h_sem;
sem_t o_sem;

void* hydrogen(void* arg) {
    sem_wait(&h_sem);
    printf("H");
    return NULL;
}

void* oxygen(void* arg) {
    sem_wait(&o_sem);
    printf("O");
    return NULL;
}

void water(int numH, int numO) {
    sem_init(&h_sem, 0, 2);
    sem_init(&o_sem, 0, 1);
    pthread_t h_threads[numH], o_threads[numO];

    for (int i = 0; i < numH; i++) {
        pthread_create(&h_threads[i], NULL, hydrogen, NULL);
    }
    for (int i = 0; i < numO; i++) {
        pthread_create(&o_threads[i], NULL, oxygen, NULL);
    }

    for (int i = 0; i < numH; i++) {
        sem_post(&h_sem);
    }
    for (int i = 0; i < numO; i++) {
        sem_post(&o_sem);
    }

    for (int i = 0; i < numH; i++) {
        pthread_join(h_threads[i], NULL);
    }
    for (int i = 0; i < numO; i++) {
        pthread_join(o_threads[i], NULL);
    }

    sem_destroy(&h_sem);
    sem_destroy(&o_sem);
}