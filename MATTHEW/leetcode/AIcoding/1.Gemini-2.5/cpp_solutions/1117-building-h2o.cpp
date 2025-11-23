#include <mutex>
#include <condition_variable>

class H2O {
private:
    std::mutex mtx;
    std::condition_variable cv_h;
    std::condition_variable cv_o;
    int h_count;
    int o_count;

public:
    H2O() : h_count(0), o_count(0) {}

    void hydrogen(std::function<void()> releaseHydrogen) {
        std::unique_lock<std::mutex> lock(mtx);

        cv_h.wait(lock, [this]{ return h_count < 2; });
        h_count++;

        if (h_count == 2 && o_count == 1) {
            h_count = 0;
            o_count = 0;
            cv_h.notify_all(); // Notify the other waiting H and this H
            cv_o.notify_one(); // Notify the waiting O
        }

        lock.unlock();
        releaseHydrogen();
    }

    void oxygen(std::function<void()> releaseOxygen) {
        std::unique_lock<std::mutex> lock(mtx);

        cv_o.wait(lock, [this]{ return o_count < 1; });
        o_count++;

        if (h_count == 2 && o_count == 1) {
            h_count = 0;
            o_count = 0;
            cv_h.notify_all(); // Notify the two waiting H's
            cv_o.notify_one(); // Notify this O
        }

        lock.unlock();
        releaseOxygen();
    }
};