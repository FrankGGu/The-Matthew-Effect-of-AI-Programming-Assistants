#include <semaphore.h>

typedef struct {
    sem_t h_sem;
    sem_t o_sem;
    sem_t mutex;
    int h_count;
} H2O;

H2O* h2oCreate() {
    H2O* obj = (H2O*) malloc(sizeof(H2O));
    sem_init(&obj->h_sem, 0, 2);
    sem_init(&obj->o_sem, 0, 1);
    sem_init(&obj->mutex, 0, 1);
    obj->h_count = 0;
    return obj;
}

void hydrogen(H2O* obj) {
    sem_wait(&obj->mutex);
    obj->h_count++;
    if (obj->h_count == 2) {
        sem_wait(&obj->o_sem);
        obj->h_count = 0;
    }
    sem_post(&obj->mutex);

    sem_wait(&obj->h_sem);

    releaseHydrogen();

    if (obj->h_count == 0) {
        sem_post(&obj->o_sem);
    } else {
        sem_post(&obj->h_sem);
    }
}

void oxygen(H2O* obj) {
    sem_wait(&obj->o_sem);

    releaseOxygen();

    sem_post(&obj->h_sem);
    sem_post(&obj->h_sem);
}

void h2oFree(H2O* obj) {
    sem_destroy(&obj->h_sem);
    sem_destroy(&obj->o_sem);
    sem_destroy(&obj->mutex);
    free(obj);
}