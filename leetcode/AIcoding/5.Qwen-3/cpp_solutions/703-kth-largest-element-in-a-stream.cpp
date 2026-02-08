#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    Solution(int k, vector<int>& nums) : k_(k) {
        for (int num : nums) {
            heap_.push(num);
        }
        while (heap_.size() > k_) {
            heap_.pop();
        }
    }

    int add(int val) {
        heap_.push(val);
        if (heap_.size() > k_) {
            heap_.pop();
        }
        return heap_.top();
    }

private:
    int k_;
    priority_queue<int, vector<int>, greater<int>> heap_;
};