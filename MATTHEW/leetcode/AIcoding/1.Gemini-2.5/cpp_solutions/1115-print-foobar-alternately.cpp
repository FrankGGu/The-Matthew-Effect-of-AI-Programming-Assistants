#include <mutex>
#include <condition_variable>
#include <functional>

class FooBar {
private:
    int n_;
    std::mutex mtx_;
    std::condition_variable cv_foo_;
    std::condition_variable cv_bar_;
    bool foo_turn_;

public:
    FooBar(int n) {
        n_ = n;
        foo_turn_ = true;
    }

    void foo(std::function<void()> printFoo) {
        for (int i = 0; i < n_; ++i) {
            std::unique_lock<std::mutex> lock(mtx_);
            cv_foo_.wait(lock, [this]{ return foo_turn_; });
            printFoo();
            foo_turn_ = false;
            cv_bar_.notify_one();
        }
    }

    void bar(std::function<void()> printBar) {
        for (int i = 0; i < n_; ++i) {
            std::unique_lock<std::mutex> lock(mtx_);
            cv_bar_.wait(lock, [this]{ return !foo_turn_; });
            printBar();
            foo_turn_ = true;
            cv_foo_.notify_one();
        }
    }
};