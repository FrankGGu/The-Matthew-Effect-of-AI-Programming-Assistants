#include <vector>
#include <stack>

class Solution {
public:
    bool validateStackSequences(std::vector<int>& pushed, std::vector<int>& popped) {
        std::stack<int> stk;
        int j = 0;

        for (int x : pushed) {
            stk.push(x);
            while (!stk.empty() && stk.top() == popped[j]) {
                stk.pop();
                j++;
            }
        }

        return j == popped.size();
    }
};