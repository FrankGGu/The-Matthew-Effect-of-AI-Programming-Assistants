#include <vector>
#include <stack>

class Solution {
public:
    bool validateStackSequences(std::vector<int>& pushed, std::vector<int>& popped) {
        std::stack<int> s;
        int popped_idx = 0;
        for (int x : pushed) {
            s.push(x);
            while (!s.empty() && popped_idx < popped.size() && s.top() == popped[popped_idx]) {
                s.pop();
                popped_idx++;
            }
        }
        return s.empty();
    }
};