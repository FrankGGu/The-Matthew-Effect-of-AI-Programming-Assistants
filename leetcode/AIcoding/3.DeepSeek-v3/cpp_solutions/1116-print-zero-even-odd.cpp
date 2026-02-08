#include <functional>
#include <mutex>
#include <condition_variable>

class ZeroEvenOdd {
private:
    int n;
    int current;
    std::mutex mtx;
    std::condition_variable cv;
    bool print_zero;

public:
    ZeroEvenOdd(int n) {
        this->n = n;
        current = 1;
        print_zero = true;
    }

    // printNumber(x) outputs "x", where x is an integer.
    void zero(function<void(int)> printNumber) {
        for (int i = 0; i < n; ++i) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return print_zero; });
            printNumber(0);
            print_zero = false;
            cv.notify_all();
        }
    }

    void even(function<void(int)> printNumber) {
        while (current <= n) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return !print_zero && current % 2 == 0; });
            if (current > n) break;
            printNumber(current);
            ++current;
            print_zero = true;
            cv.notify_all();
        }
    }

    void odd(function<void(int)> printNumber) {
        while (current <= n) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return !print_zero && current % 2 == 1; });
            if (current > n) break;
            printNumber(current);
            ++current;
            print_zero = true;
            cv.notify_all();
        }
    }
};