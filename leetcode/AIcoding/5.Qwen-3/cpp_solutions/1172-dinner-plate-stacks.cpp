#include <iostream>
#include <vector>
#include <stack>
#include <set>

using namespace std;

class Solution {
public:
    Solution(int capacity) : cap(capacity) {}

    void push(int val) {
        if (left.empty()) {
            stacks.push_back({val});
            left.insert(0);
            return;
        }
        int idx = *left.begin();
        stacks[idx].push(val);
        if (stacks[idx].size() == cap) {
            left.erase(idx);
        }
    }

    int pop() {
        if (right.empty()) {
            int idx = stacks.size() - 1;
            while (idx >= 0 && stacks[idx].empty()) {
                idx--;
            }
            if (idx < 0) {
                return -1;
            }
            int val = stacks[idx].top();
            stacks[idx].pop();
            if (stacks[idx].empty()) {
                right.erase(idx);
            } else {
                right.insert(idx);
            }
            return val;
        }
        int idx = *right.rbegin();
        int val = stacks[idx].top();
        stacks[idx].pop();
        if (stacks[idx].empty()) {
            right.erase(idx);
            left.insert(idx);
        }
        return val;
    }

    int popAt(int index) {
        if (index < 0 || index >= stacks.size() || stacks[index].empty()) {
            return -1;
        }
        int val = stacks[index].top();
        stacks[index].pop();
        if (stacks[index].empty()) {
            left.insert(index);
            right.erase(index);
        }
        return val;
    }

    int popAtStack(int index) {
        return popAt(index);
    }

private:
    int cap;
    vector<stack<int>> stacks;
    set<int> left;
    set<int> right;
};