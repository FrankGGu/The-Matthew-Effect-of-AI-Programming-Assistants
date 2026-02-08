#include <vector>
#include <stack>

class Solution {
public:
    std::vector<int> dailyTemperatures(std::vector<int>& temperatures) {
        int n = temperatures.size();
        std::vector<int> answer(n, 0);
        std::stack<int> s; // Stores indices

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && temperatures[i] > temperatures[s.top()]) {
                int prev_index = s.top();
                s.pop();
                answer[prev_index] = i - prev_index;
            }
            s.push(i);
        }

        return answer;
    }
};