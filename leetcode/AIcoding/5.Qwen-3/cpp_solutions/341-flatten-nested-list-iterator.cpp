#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class NestedInteger {
public:
    NestedInteger();
    NestedInteger(int value);
    bool isInteger() const;
    int getInteger() const;
    const vector<NestedInteger>& getList() const;
};

class Solution {
private:
    stack<const NestedInteger*> iteratorStack;

public:
    Solution(const vector<NestedInteger>& nestedList) {
        if (!nestedList.empty()) {
            iteratorStack.push(&nestedList);
        }
    }

    bool hasNext() const {
        while (!iteratorStack.empty()) {
            const NestedInteger* current = iteratorStack.top();
            if (current->isInteger()) {
                return true;
            } else {
                const vector<NestedInteger>& list = current->getList();
                iteratorStack.pop();
                for (int i = list.size() - 1; i >= 0; --i) {
                    iteratorStack.push(&list[i]);
                }
            }
        }
        return false;
    }

    int next() {
        if (hasNext()) {
            const NestedInteger* current = iteratorStack.top();
            int val = current->getInteger();
            iteratorStack.pop();
            return val;
        }
        return -1;
    }
};