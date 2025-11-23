#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
private:
    vector<int> stack;
    vector<int> minStack;

public:
    void push(int x) {
        stack.push_back(x);
        if (minStack.empty() || x <= minStack.back()) {
            minStack.push_back(x);
        }
    }

    void pop() {
        if (stack.empty()) return;
        if (stack.back() == minStack.back()) {
            minStack.pop_back();
        }
        stack.pop_back();
    }

    int top() {
        return stack.back();
    }

    int getMin() {
        return minStack.back();
    }
};