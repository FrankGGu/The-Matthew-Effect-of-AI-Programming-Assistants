#include <vector>
#include <set>
#include <algorithm>

class DinnerPlates {
private:
    std::vector<std::vector<int>> stacks;
    int capacity;
    std::set<int> push_candidates; // Stores indices of stacks that are not full
    std::set<int> pop_candidates;  // Stores indices of stacks that are not empty

public:
    DinnerPlates(int capacity) {
        this->capacity = capacity;
    }

    void push(int val) {
        if (push_candidates.empty()) {
            // All existing stacks are full, or no stacks exist yet.
            // Create a new stack at the end.
            stacks.emplace_back();
            // The newly created stack is at stacks.size() - 1.
            // It is now available for push.
            push_candidates.insert(stacks.size() - 1);
        }

        int target_idx = *push_candidates.begin(); // Get the leftmost available stack

        stacks[target_idx].push_back(val);
        pop_candidates.insert(target_idx); // This stack is now non-empty (or still non-empty)

        if (stacks[target_idx].size() == capacity) {
            push_candidates.erase(target_idx); // This stack is now full
        }
    }

    int pop() {
        if (pop_candidates.empty()) {
            return -1; // No non-empty stacks
        }

        int target_idx = *pop_candidates.rbegin(); // Get the rightmost non-empty stack

        int val = stacks[target_idx].back();
        stacks[target_idx].pop_back();

        push_candidates.insert(target_idx); // This stack is now not full (or still not full)

        if (stacks[target_idx].empty()) {
            pop_candidates.erase(target_idx); // This stack is now empty
        }
        return val;
    }

    int popAtStack(int index) {
        // If the stack at the given index does not exist or is empty, return -1.
        if (index >= stacks.size() || stacks[index].empty()) {
            return -1;
        }

        int val = stacks[index].back();
        stacks[index].pop_back();

        push_candidates.insert(index); // This stack is now not full (or still not full)

        if (stacks[index].empty()) {
            pop_candidates.erase(index); // This stack is now empty
        }
        return val;
    }
};