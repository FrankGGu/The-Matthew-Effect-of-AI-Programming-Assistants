#include <iostream>
#include <vector>
#include <deque>

using namespace std;

class Solution {
private:
    int size;
    deque<int> window;
    long long current_sum;

public:
    Solution(int size) : size(size), current_sum(0) {}

    double next(int val) {
        if (window.size() == size) {
            current_sum -= window.front();
            window.pop_front();
        }
        window.push_back(val);
        current_sum += val;
        return static_cast<double>(current_sum) / window.size();
    }
};