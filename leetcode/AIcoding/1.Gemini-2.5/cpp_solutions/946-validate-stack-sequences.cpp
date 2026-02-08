#include <vector>
#include <stack>

class Solution {
public:
    bool validateStackSequences(std::vector<int>& pushed, std::vector<int>& popped) {
        std::stack<int> s;
        int j = 0;

        for (int x : pushed) {
            s.push(x);
            while (!s.empty() && j < popped.size() && s.top() == popped[j]) {
                s.pop();
                j++;
            }
        }

        return s.empty();
    }
};