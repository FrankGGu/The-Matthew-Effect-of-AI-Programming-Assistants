#include <semaphore.h>

class H2O {
private:
    sem_t h_sem, o_sem;
    int h_count;
public:
    H2O() {
        sem_init(&h_sem, 0, 2);
        sem_init(&o_sem, 0, 0);
        h_count = 0;
    }

    void hydrogen(function<void()> releaseHydrogen) {
        sem_wait(&h_sem);
        releaseHydrogen();
        h_count++;
        if (h_count == 2) {
            h_count = 0;
            sem_post(&o_sem);
        }
    }

    void oxygen(function<void()> releaseOxygen) {
        sem_wait(&o_sem);
        releaseOxygen();
        sem_post(&h_sem);
        sem_post(&h_sem);
    }
};