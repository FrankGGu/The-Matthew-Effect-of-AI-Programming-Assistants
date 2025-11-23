#include <stdio.h>
#include <pthread.h>
#include <stdbool.h>

#define MAX_NUM 100

pthread_mutex_t lock;
int current = 1;

void fizz() {
    while (current <= MAX_NUM) {
        pthread_mutex_lock(&lock);
        if (current > MAX_NUM) {
            pthread_mutex_unlock(&lock);
            break;
        }
        if (current % 3 == 0 && current % 5 != 0) {
            printf("Fizz\n");
            current++;
        }
        pthread_mutex_unlock(&lock);
    }
}

void buzz() {
    while (current <= MAX_NUM) {
        pthread_mutex_lock(&lock);
        if (current > MAX_NUM) {
            pthread_mutex_unlock(&lock);
            break;
        }
        if (current % 5 == 0 && current % 3 != 0) {
            printf("Buzz\n");
            current++;
        }
        pthread_mutex_unlock(&lock);
    }
}

void fizzbuzz() {
    while (current <= MAX_NUM) {
        pthread_mutex_lock(&lock);
        if (current > MAX_NUM) {
            pthread_mutex_unlock(&lock);
            break;
        }
        if (current % 3 == 0 && current % 5 == 0) {
            printf("FizzBuzz\n");
            current++;
        }
        pthread_mutex_unlock(&lock);
    }
}

void number() {
    while (current <= MAX_NUM) {
        pthread_mutex_lock(&lock);
        if (current > MAX_NUM) {
            pthread_mutex_unlock(&lock);
            break;
        }
        if (current % 3 != 0 && current % 5 != 0) {
            printf("%d\n", current);
            current++;
        }
        pthread_mutex_unlock(&lock);
    }
}

void* fizzBuzz(void* arg) {
    pthread_t threads[4];
    pthread_create(&threads[0], NULL, (void*)fizz, NULL);
    pthread_create(&threads[1], NULL, (void*)buzz, NULL);
    pthread_create(&threads[2], NULL, (void*)fizzbuzz, NULL);
    pthread_create(&threads[3], NULL, (void*)number, NULL);

    for (int i = 0; i < 4; i++) {
        pthread_join(threads[i], NULL);
    }

    return NULL;
}

int main() {
    pthread_mutex_init(&lock, NULL);
    fizzBuzz(NULL);
    pthread_mutex_destroy(&lock);
    return 0;
}