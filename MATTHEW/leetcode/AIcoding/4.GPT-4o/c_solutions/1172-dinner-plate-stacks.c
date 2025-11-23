#include <vector>
#include <stack>
#include <queue>

class DinnerPlate {
public:
    std::vector<std::stack<int>> stacks;
    std::priority_queue<int, std::vector<int>, std::greater<int>> availableStacks;
    int capacity;

    DinnerPlate(int capacity) {
        this->capacity = capacity;
    }

    void push(int val) {
        if (availableStacks.empty() || stacks.size() == availableStacks.top()) {
            stacks.emplace_back();
            availableStacks.push(stacks.size() - 1);
        }
        stacks[availableStacks.top()].push(val);
        if (stacks[availableStacks.top()].size() == capacity) {
            availableStacks.pop();
        }
    }

    int pop() {
        while (!availableStacks.empty() && stacks[availableStacks.top()].empty()) {
            availableStacks.pop();
        }
        if (availableStacks.empty()) return -1;

        int index = availableStacks.top();
        int val = stacks[index].top();
        stacks[index].pop();

        if (stacks[index].size() == capacity - 1) {
            availableStacks.push(index);
        }
        return val;
    }

    int popAtStack(int index) {
        if (index >= stacks.size() || stacks[index].empty()) return -1;

        int val = stacks[index].top();
        stacks[index].pop();

        if (stacks[index].size() == capacity - 1) {
            availableStacks.push(index);
        }
        return val;
    }
};