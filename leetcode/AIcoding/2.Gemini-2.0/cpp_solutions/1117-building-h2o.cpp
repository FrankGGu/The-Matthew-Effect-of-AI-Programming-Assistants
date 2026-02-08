#include <mutex>
#include <condition_variable>

class H2O {
private:
    std::mutex mtx;
    std::condition_variable cv;
    int h_count = 0;
    int o_count = 0;

public:
    H2O() {}

    void hydrogen(std::function<void()> releaseHydrogen) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return h_count < 2; });
        releaseHydrogen();
        h_count++;
        cv.notify_all();
        if (h_count == 2 && o_count == 1) {
            h_count = 0;
            o_count = 0;
        }
    }

    void oxygen(std::function<void()> releaseOxygen) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this] { return o_count < 1; });
        releaseOxygen();
        o_count++;
        cv.notify_all();
        if (h_count == 2 && o_count == 1) {
            h_count = 0;
            o_count = 0;
        }
    }
};