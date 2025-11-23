#include <functional>
#include <mutex>
#include <condition_variable>

class ZeroEvenOdd {
private:
    int n_;
    std::mutex mtx_;
    std::condition_variable cv_;
    int current_num_; // Represents the number (1 to n) that odd/even will print next
    int turn_;        // 0 for zero, 1 for odd, 2 for even

public:
    ZeroEvenOdd(int n) : n_(n), current_num_(1), turn_(0) {}

    // printNumber(x) outputs "x", where x is an integer.
    void zero(std::function<void(int)> printNumber) {
        for (int i = 0; i < n_; ++i) {
            std::unique_lock<std::mutex> lock(mtx_);
            cv_.wait(lock, [this]() { return turn_ == 0; });

            printNumber(0);

            if (current_num_ % 2 != 0) { // If current_num_ is odd, next turn is odd
                turn_ = 1;
            } else { // If current_num_ is even, next turn is even
                turn_ = 2;
            }
            cv_.notify_all();
        }
    }

    void even(std::function<void(int)> printNumber) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx_);
            cv_.wait(lock, [this]() {
                // Wait if it's not even's turn, or if current_num_ is odd, or if all numbers are processed
                return (turn_ == 2 && current_num_ % 2 == 0) || current_num_ > n_;
            });

            if (current_num_ > n_) {
                cv_.notify_all(); // Wake up any other waiting threads to let them exit
                return;
            }

            printNumber(current_num_);
            current_num_++;
            turn_ = 0; // After printing an even number, it's zero's turn again
            cv_.notify_all();
        }
    }

    void odd(std::function<void(int)> printNumber) {
        while (true) {
            std::unique_lock<std::mutex> lock(mtx_);
            cv_.wait(lock, [this]() {
                // Wait if it's not odd's turn, or if current_num_ is even, or if all numbers are processed
                return (turn_ == 1 && current_num_ % 2 != 0) || current_num_ > n_;
            });

            if (current_num_ > n_) {
                cv_.notify_all(); // Wake up any other waiting threads to let them exit
                return;
            }

            printNumber(current_num_);
            current_num_++;
            turn_ = 0; // After printing an odd number, it's zero's turn again
            cv_.notify_all();
        }
    }
};