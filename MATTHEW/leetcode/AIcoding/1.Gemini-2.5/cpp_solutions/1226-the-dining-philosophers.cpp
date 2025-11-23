#include <iostream>
#include <thread>
#include <mutex>
#include <vector>

class DiningPhilosophers {
private:
    std::mutex forks[5];
    std::mutex print_mutex;

public:
    DiningPhilosophers() {}

    void wantsToEat(int philosopher,
                    std::function<void()> pickLeftFork,
                    std::function<void()> pickRightFork,
                    std::function<void()> eat,
                    std::function<void()> putLeftFork,
                    std::function<void()> putRightFork) {
        int leftFork = philosopher;
        int rightFork = (philosopher + 1) % 5;

        if (philosopher % 2 == 0) {
            forks[leftFork].lock();
            pickLeftFork();
            forks[rightFork].lock();
            pickRightFork();
        } else {
            forks[rightFork].lock();
            pickRightFork();
            forks[leftFork].lock();
            pickLeftFork();
        }

        eat();

        putLeftFork();
        forks[leftFork].unlock();
        putRightFork();
        forks[rightFork].unlock();
    }
};