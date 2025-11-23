#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    sem_t hydrogen;
    sem_t oxygen;
    sem_t mutex;
    int h_count;
} H2O;

H2O* h2oCreate() {
    H2O* obj = (H2O*)malloc(sizeof(H2O));
    sem_init(&obj->hydrogen, 0, 0);
    sem_init(&obj->oxygen, 0, 0);
    sem_init(&obj->mutex, 0, 1);
    obj->h_count = 0;
    return obj;
}

void hydrogen(H2O* obj, void (*releaseHydrogen)()) {
    sem_wait(&obj->mutex);
    obj->h_count++;
    if (obj->h_count >= 2) {
        sem_post(&obj->hydrogen);
        sem_post(&obj->hydrogen);
        sem_post(&obj->oxygen);
        obj->h_count -= 2;
    } else {
        sem_post(&obj->mutex);
    }
    sem_wait(&obj->hydrogen);
    releaseHydrogen();
    sem_post(&obj->mutex);
}

void oxygen(H2O* obj, void (*releaseOxygen)()) {
    sem_wait(&obj->oxygen);
    releaseOxygen();
}

void h2oFree(H2O* obj) {
    sem_destroy(&obj->hydrogen);
    sem_destroy(&obj->oxygen);
    sem_destroy(&obj->mutex);
    free(obj);
}