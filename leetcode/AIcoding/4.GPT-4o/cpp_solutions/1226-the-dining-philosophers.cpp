#include <condition_variable>
#include <mutex>
#include <thread>
#include <vector>

class DiningPhilosophers {
public:
    DiningPhilosophers() {
        for (int i = 0; i < 5; ++i) {
            forks[i] = std::make_unique<std::mutex>();
        }
    }

    void wantsToEat(int philosopher, std::function<void()> eat) {
        int left = philosopher;
        int right = (philosopher + 1) % 5;

        std::unique_lock<std::mutex> lock(mtx);
        forks[left]->lock();
        forks[right]->lock();

        eat();

        forks[right]->unlock();
        forks[left]->unlock();
    }

private:
    std::mutex mtx;
    std::unique_ptr<std::mutex> forks[5];
};