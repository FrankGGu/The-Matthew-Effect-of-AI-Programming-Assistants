#include <functional>
#include <mutex>
#include <condition_variable>

class FizzBuzz {
private:
    int n;
    int current;
    std::mutex mtx;
    std::condition_variable cv;

public:
    FizzBuzz(int n) {
        this->n = n;
        this->current = 1;
    }

    void fizz(function<void()> printFizz) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() { return current > n || (current % 3 == 0 && current % 5 != 0); });
            if (current > n) break;
            printFizz();
            ++current;
            cv.notify_all();
        }
    }

    void buzz(function<void()> printBuzz) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() { return current > n || (current % 5 == 0 && current % 3 != 0); });
            if (current > n) break;
            printBuzz();
            ++current;
            cv.notify_all();
        }
    }

    void fizzbuzz(function<void()> printFizzBuzz) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() { return current > n || (current % 3 == 0 && current % 5 == 0); });
            if (current > n) break;
            printFizzBuzz();
            ++current;
            cv.notify_all();
        }
    }

    void number(function<void(int)> printNumber) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() { return current > n || (current % 3 != 0 && current % 5 != 0); });
            if (current > n) break;
            printNumber(current);
            ++current;
            cv.notify_all();
        }
    }
};