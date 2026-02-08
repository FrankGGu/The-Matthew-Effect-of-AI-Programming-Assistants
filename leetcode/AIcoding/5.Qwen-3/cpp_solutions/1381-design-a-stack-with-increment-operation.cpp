#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
    vector<int> stack;
    int size;

public:
    Solution(int maxSize) {
        size = maxSize;
    }

    void push(int x) {
        if (stack.size() < size) {
            stack.push_back(x);
        }
    }

    int pop(int k) {
        int res = 0;
        for (int i = 0; i < k; ++i) {
            if (!stack.empty()) {
                res += stack.back();
                stack.pop_back();
            }
        }
        return res;
    }

    void increment(int k, int val) {
        for (int i = 0; i < k && i < stack.size(); ++i) {
            stack[i] += val;
        }
    }
};