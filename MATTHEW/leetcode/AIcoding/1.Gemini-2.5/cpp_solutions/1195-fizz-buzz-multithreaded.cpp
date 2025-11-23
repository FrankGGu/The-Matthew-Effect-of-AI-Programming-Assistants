#include <functional>
#include <mutex>
#include <condition_variable>

class FizzBuzz {
private:
    int n;
    int current_num;
    std::mutex mtx;
    std::condition_variable cv;

public:
    FizzBuzz(int n) {
        this->n = n;
        this->current_num = 1;
    }

    void fizz(std::function<void()> printFizz) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() {
                return current_num > n || (current_num % 3 == 0 && current_num % 5 != 0);
            });

            if (current_num > n) {
                return;
            }

            printFizz();
            current_num++;
            cv.notify_all();
        }
    }

    void buzz(std::function<void()> printBuzz) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() {
                return current_num > n || (current_num % 5 == 0 && current_num % 3 != 0);
            });

            if (current_num > n) {
                return;
            }

            printBuzz();
            current_num++;
            cv.notify_all();
        }
    }

    void fizzbuzz(std::function<void()> printFizzBuzz) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() {
                return current_num > n || (current_num % 3 == 0 && current_num % 5 == 0);
            });

            if (current_num > n) {
                return;
            }

            printFizzBuzz();
            current_num++;
            cv.notify_all();
        }
    }

    void number(std::function<void(int)> printNumber) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this]() {
                return current_num > n || (current_num % 3 != 0 && current_num % 5 != 0);
            });

            if (current_num > n) {
                return;
            }

            printNumber(current_num);
            current_num++;
            cv.notify_all();
        }
    }
};