#include <mutex>
#include <condition_variable>
#include <functional>

class FizzBuzz {
private:
    int n;
    std::mutex mtx;
    std::condition_variable cv;
    int count;

public:
    FizzBuzz(int n) {
        this->n = n;
        count = 1;
    }

    void fizz(std::function<void()> printFizz) {
        for (int i = 1; i <= n; i++) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() { return count > n || count % 3 == 0 && count % 5 != 0; });
            if (count <= n) {
                printFizz();
                count++;
            }
            cv.notify_all();
        }
    }

    void buzz(std::function<void()> printBuzz) {
        for (int i = 1; i <= n; i++) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() { return count > n || count % 5 == 0 && count % 3 != 0; });
            if (count <= n) {
                printBuzz();
                count++;
            }
            cv.notify_all();
        }
    }

    void fizzbuzz(std::function<void()> printFizzBuzz) {
        for (int i = 1; i <= n; i++) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() { return count > n || (count % 3 == 0 && count % 5 == 0); });
            if (count <= n) {
                printFizzBuzz();
                count++;
            }
            cv.notify_all();
        }
    }

    void number(std::function<void(int)> printNumber) {
        for (int i = 1; i <= n; i++) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this, i]() { return count > n || (count % 3 != 0 && count % 5 != 0 && count == i); });
            if (count <= n) {
                printNumber(count);
                count++;
            }
            cv.notify_all();
        }
    }
};