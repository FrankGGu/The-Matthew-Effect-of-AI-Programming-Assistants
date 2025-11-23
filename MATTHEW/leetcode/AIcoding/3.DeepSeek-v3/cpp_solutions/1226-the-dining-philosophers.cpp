#include <semaphore.h>

class DiningPhilosophers {
private:
    sem_t forks[5];
    sem_t mutex;

public:
    DiningPhilosophers() {
        for (int i = 0; i < 5; ++i) {
            sem_init(&forks[i], 0, 1);
        }
        sem_init(&mutex, 0, 1);
    }

    void wantsToEat(int philosopher,
                    function<void()> pickLeftFork,
                    function<void()> pickRightFork,
                    function<void()> eat,
                    function<void()> putLeftFork,
                    function<void()> putRightFork) {
        int left = philosopher;
        int right = (philosopher + 1) % 5;

        sem_wait(&mutex);
        sem_wait(&forks[left]);
        sem_wait(&forks[right]);
        sem_post(&mutex);

        pickLeftFork();
        pickRightFork();

        eat();

        putRightFork();
        putLeftFork();

        sem_post(&forks[right]);
        sem_post(&forks[left]);
    }
};