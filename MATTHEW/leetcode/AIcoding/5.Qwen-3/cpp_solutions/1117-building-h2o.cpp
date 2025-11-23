#include <iostream>
#include <vector>
#include <mutex>
#include <condition_variable>

using namespace std;

class Solution {
private:
    mutex m;
    condition_variable cv;
    int h_count = 0;
    int o_count = 0;
    int total = 0;

public:
    Solution() {}

    void hydrogen(function<void()> releaseHydrogen) {
        unique_lock<mutex> lock(m);
        cv.wait(lock, [this] { return h_count < 2; });
        releaseHydrogen();
        h_count++;
        if (h_count == 2 && o_count == 1) {
            h_count = 0;
            o_count = 0;
            total += 1;
        }
        cv.notify_all();
    }

    void oxygen(function<void()> releaseOxygen) {
        unique_lock<mutex> lock(m);
        cv.wait(lock, [this] { return o_count < 1; });
        releaseOxygen();
        o_count++;
        if (h_count == 2 && o_count == 1) {
            h_count = 0;
            o_count = 0;
            total += 1;
        }
        cv.notify_all();
    }
};