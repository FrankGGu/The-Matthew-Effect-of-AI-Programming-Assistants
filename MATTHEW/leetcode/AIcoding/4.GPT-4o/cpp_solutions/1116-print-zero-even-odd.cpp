#include <condition_variable>
#include <functional>
#include <mutex>
#include <thread>

class ZeroEvenOdd {
private:
    int n;
    int count;
    std::mutex m;
    std::condition_variable cv;

public:
    ZeroEvenOdd(int n) {
        this->n = n;
        count = 0;
    }

    void zero(function<void(int)> printNumber) {
        for (int i = 0; i < n; i++) {
            std::unique_lock<std::mutex> lock(m);
            cv.wait(lock, [this]() { return count % 2 == 0; });
            printNumber(0);
            count++;
            cv.notify_all();
        }
    }

    void even(function<void(int)> printNumber) {
        for (int i = 2; i <= n; i += 2) {
            std::unique_lock<std::mutex> lock(m);
            cv.wait(lock, [this]() { return count % 2 == 1; });
            printNumber(i);
            count++;
            cv.notify_all();
        }
    }

    void odd(function<void(int)> printNumber) {
        for (int i = 1; i <= n; i += 2) {
            std::unique_lock<std::mutex> lock(m);
            cv.wait(lock, [this]() { return count % 2 == 1; });
            printNumber(i);
            count++;
            cv.notify_all();
        }
    }
};