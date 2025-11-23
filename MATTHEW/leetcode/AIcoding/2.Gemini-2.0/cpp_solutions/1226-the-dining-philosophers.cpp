#include <vector>
#include <mutex>
#include <thread>
#include <condition_variable>

class DiningPhilosophers {
private:
    std::vector<std::mutex> forks;
    std::mutex print_mutex;
    std::condition_variable cv;
    std::vector<bool> eating;

public:
    DiningPhilosophers() : forks(5), eating(5, false) {}

    void wantsToEat(int philosopher,
                    std::function<void()> pickLeftFork,
                    std::function<void()> pickRightFork,
                    std::function<void()> eat,
                    std::function<void()> putLeftFork,
                    std::function<void()> putRightFork) {
        int left = philosopher;
        int right = (philosopher + 1) % 5;

        std::unique_lock<std::mutex> lock(print_mutex);
        cv.wait(lock, [&]{return !eating[left] && !eating[right];});

        eating[left] = true;
        eating[right] = true;

        forks[left].lock();
        pickLeftFork();

        forks[right].lock();
        pickRightFork();

        eat();

        putLeftFork();
        forks[left].unlock();

        putRightFork();
        forks[right].unlock();

        eating[left] = false;
        eating[right] = false;

        cv.notify_all();
    }
};