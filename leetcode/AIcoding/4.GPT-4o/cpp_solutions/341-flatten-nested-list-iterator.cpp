#include <vector>
#include <stack>

class NestedInteger {
public:
    // Return true if this NestedInteger holds a single integer, rather than a nested list.
    bool isInteger() const;

    // Return the single integer that this NestedInteger holds, if it holds a single integer
    // The result is undefined if this NestedInteger holds a nested list
    int getInteger() const;

    // Return the nested list that this NestedInteger holds, if it holds a nested list
    // The result is undefined if this NestedInteger holds a single integer
    const std::vector<NestedInteger>& getList() const;
};

class NestedIterator {
    std::stack<NestedInteger> stk;

public:
    NestedIterator(std::vector<NestedInteger> &nestedList) {
        for (auto it = nestedList.rbegin(); it != nestedList.rend(); ++it) {
            stk.push(*it);
        }
    }

    int next() {
        int value = stk.top().getInteger();
        stk.pop();
        return value;
    }

    bool hasNext() {
        while (!stk.empty()) {
            if (stk.top().isInteger()) {
                return true;
            }
            auto nestedList = stk.top().getList();
            stk.pop();
            for (auto it = nestedList.rbegin(); it != nestedList.rend(); ++it) {
                stk.push(*it);
            }
        }
        return false;
    }
};