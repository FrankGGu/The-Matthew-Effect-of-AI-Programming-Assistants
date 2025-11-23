#include <vector>
#include <set>

using namespace std;

class DinnerPlates {
public:
    DinnerPlates(int capacity) : capacity_(capacity) {

    }

    void push(int val) {
        if (available_.empty()) {
            if (stacks_.empty() || stacks_.back().size() == capacity_) {
                stacks_.push_back({});
            }
            stacks_.back().push_back(val);
            if (stacks_.back().size() == capacity_) {
            } else {
                available_.insert(stacks_.size() - 1);
            }
        } else {
            int index = *available_.begin();
            stacks_[index].push_back(val);
            if (stacks_[index].size() == capacity_) {
                available_.erase(index);
            }
        }
    }

    int pop() {
        while (!stacks_.empty() && stacks_.back().empty()) {
            stacks_.pop_back();
        }
        if (stacks_.empty()) {
            return -1;
        }
        int val = stacks_.back().back();
        stacks_.back().pop_back();
        available_.insert(stacks_.size() - 1);
        return val;
    }

    int popAtStack(int index) {
        if (index < 0 || index >= stacks_.size() || stacks_[index].empty()) {
            return -1;
        }
        int val = stacks_[index].back();
        stacks_[index].pop_back();
        available_.insert(index);
        while (!stacks_.empty() && stacks_.back().empty()) {
            stacks_.pop_back();
        }
        return val;
    }

private:
    vector<vector<int>> stacks_;
    int capacity_;
    set<int> available_;
};