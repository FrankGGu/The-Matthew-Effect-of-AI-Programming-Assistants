#include <functional>
#include <mutex>
#include <condition_variable>

using namespace std;

class FizzBuzz {
private:
    int n;
    int current;
    mutex mtx;
    condition_variable cv;

public:
    FizzBuzz(int n) {
        this->n = n;
        this->current = 1;
    }

    void fizz(function<void()> printFizz) {
        while (current <= n) {
            unique_lock<mutex> lock(mtx);
            cv.wait(lock, [&]() { return current > n || (current % 3 == 0 && current % 5 != 0); });
            if (current > n) return;
            printFizz();
            current++;
            cv.notify_all();
        }
    }

    void buzz(function<void()> printBuzz) {
        while (current <= n) {
            unique_lock<mutex> lock(mtx);
            cv.wait(lock, [&]() { return current > n || (current % 3 != 0 && current % 5 == 0); });
            if (current > n) return;
            printBuzz();
            current++;
            cv.notify_all();
        }
    }

    void fizzbuzz(function<void()> printFizzBuzz) {
        while (current <= n) {
            unique_lock<mutex> lock(mtx);
            cv.wait(lock, [&]() { return current > n || (current % 3 == 0 && current % 5 == 0); });
            if (current > n) return;
            printFizzBuzz();
            current++;
            cv.notify_all();
        }
    }

    void number(function<void(int)> printNumber) {
        while (current <= n) {
            unique_lock<mutex> lock(mtx);
            cv.wait(lock, [&]() { return current > n || (current % 3 != 0 && current % 5 != 0); });
            if (current > n) return;
            printNumber(current);
            current++;
            cv.notify_all();
        }
    }
};