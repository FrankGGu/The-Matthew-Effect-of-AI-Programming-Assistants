#include <stdlib.h>
#include <pthread.h>

typedef struct {
    int n;
    pthread_mutex_t mutex;
    pthread_cond_t cond_foo;
    pthread_cond_t cond_bar;
    int turn; // 0 for foo, 1 for bar
} FooBar;

FooBar* fooBarCreate(int n) {
    FooBar* obj = (FooBar*) malloc(sizeof(FooBar));
    obj->n = n;
    pthread_mutex_init(&obj->mutex, NULL);
    pthread_cond_init(&obj->cond_foo, NULL);
    pthread_cond_init(&obj->cond_bar, NULL);
    obj->turn = 0; // Foo starts first
    return obj;
}

void foo(FooBar* obj, void (*printFoo)(void)) {
    for (int i = 0; i < obj->n; i++) {
        pthread_mutex_lock(&obj->mutex);
        while (obj->turn != 0) {
            pthread_cond_wait(&obj->cond_foo, &obj->mutex);
        }
        // printFoo() outputs "foo". Do not change or remove this line.
        printFoo();
        obj->turn = 1;
        pthread_cond_signal(&obj->cond_bar);
        pthread_mutex_unlock(&obj->mutex);
    }
}

void bar(FooBar* obj, void (*printBar)(void)) {
    for (int i = 0; i < obj->n; i++) {
        pthread_mutex_lock(&obj->mutex);
        while (obj->turn != 1) {
            pthread_cond_wait(&obj->cond_bar, &obj->mutex);
        }
        // printBar() outputs "bar". Do not change or remove this line.
        printBar();
        obj->turn = 0;
        pthread_cond_signal(&obj->cond_foo);
        pthread_mutex_unlock(&obj->mutex);
    }
}

void fooBarFree(FooBar* obj) {
    pthread_mutex_destroy(&obj->mutex);
    pthread_cond_destroy(&obj->cond_foo);
    pthread_cond_destroy(&obj->cond_bar);
    free(obj);
}