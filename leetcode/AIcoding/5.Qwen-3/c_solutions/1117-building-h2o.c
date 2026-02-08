#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

typedef struct {
    sem_t h;
    sem_t o;
    int h_count;
} H2O;

H2O* h2oCreate() {
    H2O* obj = (H2O*)malloc(sizeof(H2O));
    sem_init(&obj->h, 0, 2);
    sem_init(&obj->o, 0, 1);
    obj->h_count = 0;
    return obj;
}

void water(H2O* obj, void (*output)(char)) {
    sem_wait(&obj->h);
    obj->h_count++;
    if (obj->h_count == 2) {
        sem_post(&obj->o);
    }
    output('H');
    if (obj->h_count == 2) {
        sem_wait(&obj->o);
        output('O');
        obj->h_count = 0;
        sem_post(&obj->h);
        sem_post(&obj->h);
    }
}

void hydrogen(H2O* obj, void (*output)(char)) {
    sem_wait(&obj->h);
    obj->h_count++;
    if (obj->h_count == 2) {
        sem_post(&obj->o);
    }
    output('H');
    if (obj->h_count == 2) {
        sem_wait(&obj->o);
        output('O');
        obj->h_count = 0;
        sem_post(&obj->h);
        sem_post(&obj->h);
    }
}

void oxygen(H2O* obj, void (*output)(char)) {
    sem_wait(&obj->o);
    output('O');
    sem_post(&obj->h);
    sem_post(&obj->h);
}