class DinnerPlates {
public:
    DinnerPlates(int capacity) : cap(capacity) {
    }

    void push(int val) {
        if (avail.empty()) {
            stacks.emplace_back(stack<int>());
            avail.insert(stacks.size() - 1);
        }
        int idx = *avail.begin();
        stacks[idx].push(val);
        if (stacks[idx].size() == cap) {
            avail.erase(idx);
        }
    }

    int pop() {
        while (!stacks.empty() && stacks.back().empty()) {
            stacks.pop_back();
            avail.erase(stacks.size());
        }
        if (stacks.empty()) return -1;
        int val = stacks.back().top();
        stacks.back().pop();
        if (stacks.back().empty()) {
            stacks.pop_back();
            avail.erase(stacks.size());
        }
        return val;
    }

    int popAtStack(int index) {
        if (index >= stacks.size() || stacks[index].empty()) return -1;
        int val = stacks[index].top();
        stacks[index].pop();
        avail.insert(index);
        return val;
    }

private:
    int cap;
    vector<stack<int>> stacks;
    set<int> avail;
};