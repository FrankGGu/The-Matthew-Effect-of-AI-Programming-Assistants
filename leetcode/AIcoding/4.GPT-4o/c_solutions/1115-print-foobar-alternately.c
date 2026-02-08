#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

sem_t semFoo;
sem_t semBar;

void* foo(void* arg) {
    for (int i = 0; i < *(int*)arg; i++) {
        sem_wait(&semFoo);
        printf("Foo");
        sem_post(&semBar);
    }
    return NULL;
}

void* bar(void* arg) {
    for (int i = 0; i < *(int*)arg; i++) {
        sem_wait(&semBar);
        printf("Bar");
        sem_post(&semFoo);
    }
    return NULL;
}

void printFooBar(int n) {
    sem_init(&semFoo, 0, 1);
    sem_init(&semBar, 0, 0);

    pthread_t thread1, thread2;
    pthread_create(&thread1, NULL, foo, &n);
    pthread_create(&thread2, NULL, bar, &n);

    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);

    sem_destroy(&semFoo);
    sem_destroy(&semBar);
}