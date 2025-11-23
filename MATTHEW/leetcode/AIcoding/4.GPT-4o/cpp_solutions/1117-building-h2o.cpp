#include <condition_variable>
#include <mutex>
#include <thread>

class H2O {
private:
    std::mutex mtx;
    std::condition_variable cv;
    int hCount = 0;

public:
    H2O() {}

    void hydrogen(function<void()> releaseHydrogen) {
        std::unique_lock<std::mutex> lock(mtx);
        hCount++;
        if (hCount == 2) {
            cv.notify_all();
        }
        lock.unlock();
        releaseHydrogen();
        lock.lock();
        cv.wait(lock, [&]() { return hCount == 2; });
        hCount--;
        if (hCount == 0) {
            cv.notify_all();
        }
    }

    void oxygen(function<void()> releaseOxygen) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [&]() { return hCount >= 2; });
        releaseOxygen();
        hCount -= 2;
        cv.notify_all();
    }
};