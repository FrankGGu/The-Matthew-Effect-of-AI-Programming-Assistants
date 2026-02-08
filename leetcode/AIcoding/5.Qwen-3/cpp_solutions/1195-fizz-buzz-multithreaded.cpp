#include <iostream>
#include <vector>
#include <thread>
#include <mutex>
#include <condition_variable>

class Solution {
public:
    void fizzBuzz(int n) {
        std::mutex m;
        std::condition_variable cv;
        int i = 1;
        bool done = false;

        auto printFizz = [&]() {
            while (true) {
                std::unique_lock<std::mutex> lock(m);
                cv.wait(lock, [&]() { return i > n || (i % 3 == 0 && i % 5 != 0); });
                if (i > n) break;
                std::cout << "Fizz" << std::endl;
                ++i;
                cv.notify_all();
            }
        };

        auto printBuzz = [&]() {
            while (true) {
                std::unique_lock<std::mutex> lock(m);
                cv.wait(lock, [&]() { return i > n || (i % 5 == 0 && i % 3 != 0); });
                if (i > n) break;
                std::cout << "Buzz" << std::endl;
                ++i;
                cv.notify_all();
            }
        };

        auto printFizzBuzz = [&]() {
            while (true) {
                std::unique_lock<std::mutex> lock(m);
                cv.wait(lock, [&]() { return i > n || (i % 3 == 0 && i % 5 == 0); });
                if (i > n) break;
                std::cout << "FizzBuzz" << std::endl;
                ++i;
                cv.notify_all();
            }
        };

        auto printNumber = [&]() {
            while (true) {
                std::unique_lock<std::mutex> lock(m);
                cv.wait(lock, [&]() { return i > n || (i % 3 != 0 && i % 5 != 0); });
                if (i > n) break;
                std::cout << i << std::endl;
                ++i;
                cv.notify_all();
            }
        };

        std::thread t1(printFizz);
        std::thread t2(printBuzz);
        std::thread t3(printFizzBuzz);
        std::thread t4(printNumber);

        t1.join();
        t2.join();
        t3.join();
        t4.join();
    }
};