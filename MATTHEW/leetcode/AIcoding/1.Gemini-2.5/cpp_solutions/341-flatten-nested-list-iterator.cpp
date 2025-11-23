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
    const std::vector<NestedInteger> &getList() const;
};

class NestedIterator {
private:
    std::stack<const NestedInteger*> s;

    void pushListToStack(const std::vector<NestedInteger>& list) {
        for (int i = list.size() - 1; i >= 0; --i) {
            s.push(&list[i]);
        }
    }

public:
    NestedIterator(const std::vector<NestedInteger> &nestedList) {
        pushListToStack(nestedList);
    }

    int next() {
        int result = s.top()->getInteger();
        s.pop();
        return result;
    }

    bool hasNext() {
        while (!s.empty()) {
            const NestedInteger* current = s.top();
            if (current->isInteger()) {
                return true;
            } else {
                s.pop();
                pushListToStack(current->getList());
            }
        }
        return false;
    }
};