#include <pthread.h>
#include <stdlib.h>

typedef struct {
    pthread_mutex_t mutex;
    pthread_cond_t h_cond;
    pthread_cond_t o_cond;
    int h_count;
    int o_count;
} H2O;

H2O* h2oCreate() {
    H2O* obj = (H2O*) malloc(sizeof(H2O));
    pthread_mutex_init(&obj->mutex, NULL);
    pthread_cond_init(&obj->h_cond, NULL);
    pthread_cond_init(&obj->o_cond, NULL);
    obj->h_count = 0;
    obj->o_count = 0;
    return obj;
}

void hydrogen(H2O* obj, void (*releaseHydrogen)()) {
    pthread_mutex_lock(&obj->mutex);

    while (obj->h_count == 2) {
        pthread_cond_wait(&obj->h_cond, &obj->mutex);
    }

    releaseHydrogen();
    obj->h_count++;

    if (obj->h_count == 2 && obj->o_count == 1) {
        obj->h_count = 0;
        obj->o_count = 0;
        pthread_cond_broadcast(&obj->h_cond);
        pthread_cond_broadcast(&obj->o_cond);
    } else {
        pthread_cond_broadcast(&obj->h_cond);
        pthread_cond_broadcast(&obj->o_cond);
    }

    pthread_mutex_unlock(&obj->mutex);
}

void oxygen(H2O* obj, void (*releaseOxygen)()) {
    pthread_mutex_lock(&obj->mutex);

    while (obj->o_count == 1 || obj->h_count < 2) {
        pthread_cond_wait(&obj->o_cond, &obj->mutex);
    }

    releaseOxygen();
    obj->o_count++;

    obj->h_count = 0;
    obj->o_count = 0;
    pthread_cond_broadcast(&obj->h_cond);
    pthread_cond_broadcast(&obj->o_cond);

    pthread_mutex_unlock(&obj->mutex);
}

void h2oFree(H2O* obj) {
    pthread_mutex_destroy(&obj->mutex);
    pthread_cond_destroy(&obj->h_cond);
    pthread_cond_destroy(&obj->o_cond);
    free(obj);
}