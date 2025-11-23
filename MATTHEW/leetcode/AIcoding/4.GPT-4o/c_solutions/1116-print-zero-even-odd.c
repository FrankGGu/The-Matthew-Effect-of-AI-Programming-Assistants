#include <pthread.h>
#include <stdio.h>

volatile int turn = 0; // 0 for zero, 1 for even, 2 for odd
int n;

void printNumber(int num) {
    printf("%d\n", num);
}

void* zero(void* arg) {
    for (int i = 0; i < n; i++) {
        while (turn != 0);
        printNumber(0);
        turn = (i % 2 == 0) ? 1 : 2;
    }
    return NULL;
}

void* even(void* arg) {
    for (int i = 2; i <= n; i += 2) {
        while (turn != 1);
        printNumber(i);
        turn = 0;
    }
    return NULL;
}

void* odd(void* arg) {
    for (int i = 1; i <= n; i += 2) {
        while (turn != 2);
        printNumber(i);
        turn = 0;
    }
    return NULL;
}

void printNumbers(int nVal) {
    n = nVal;
    pthread_t t1, t2, t3;
    pthread_create(&t1, NULL, zero, NULL);
    pthread_create(&t2, NULL, even, NULL);
    pthread_create(&t3, NULL, odd, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);
}