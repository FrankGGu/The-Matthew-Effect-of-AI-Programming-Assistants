#include <iostream>
#include <vector>
#include <mutex>
#include <thread>
#include <atomic>

using namespace std;

class Solution {
public:
    void wantsToEat(int philosopher,
                    function<void(int)> pickLeftFork,
                    function<void(int)> pickRightFork,
                    function<void(int)> eat,
                    function<void(int)> putLeftFork,
                    function<void(int)> putRightFork) {
        static vector<mutex> forks(5);
        static atomic<int> count = 0;

        int left = philosopher;
        int right = (philosopher + 1) % 5;

        while (true) {
                        if (forks[left].try_lock() && forks[right].try_lock()) {
                break;
            }

                        this_thread::sleep_for(chrono::milliseconds(1));
        }

        pickLeftFork(philosopher);
        pickRightFork(philosopher);
        eat(philosopher);
        putLeftFork(philosopher);
        putRightFork(philosopher);

        forks[left].unlock();
        forks[right].unlock();
    }
};