
class Foo {
private:
    std::mutex mtx;
    std::condition_variable cv;
    int state;

public:
    Foo() : state(0) {}

    void first(function<void()> printFirst) {
        std::unique_lock<std::mutex> lock(mtx);
        printFirst();
        state = 1;
        cv.notify_all();
    }

    void second(function<void()> printSecond) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return state == 1; });
        printSecond();
        state = 2;
        cv.notify_all();
    }

    void third(function<void()> printThird) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return state == 2; });
        printThird();
    }
};