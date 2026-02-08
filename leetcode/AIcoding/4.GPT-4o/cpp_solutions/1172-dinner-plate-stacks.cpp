class DinnerPlate {
public:
    vector<vector<int>> stacks;
    priority_queue<int, vector<int>, greater<int>> availableStacks;

    DinnerPlate(int capacity) : capacity(capacity) {}

    void push(int val) {
        if (availableStacks.empty() || stacks[availableStacks.top()].size() == capacity) {
            stacks.push_back(vector<int>());
            availableStacks.push(stacks.size() - 1);
        }
        stacks[availableStacks.top()].push_back(val);
        if (stacks[availableStacks.top()].size() == capacity) {
            availableStacks.pop();
        }
    }

    int pop() {
        while (!stacks.empty() && stacks.back().empty()) {
            stacks.pop_back();
            if (!availableStacks.empty()) {
                availableStacks.pop();
            }
        }
        if (stacks.empty()) return -1;
        int val = stacks.back().back();
        stacks.back().pop_back();
        if (stacks.size() - 1 < availableStacks.size() || stacks.back().size() < capacity) {
            availableStacks.push(stacks.size() - 1);
        }
        return val;
    }

    int popAtStack(int index) {
        if (index >= stacks.size() || stacks[index].empty()) return -1;
        int val = stacks[index].back();
        stacks[index].pop_back();
        if (stacks[index].size() < capacity) {
            availableStacks.push(index);
        }
        return val;
    }

private:
    int capacity;
};