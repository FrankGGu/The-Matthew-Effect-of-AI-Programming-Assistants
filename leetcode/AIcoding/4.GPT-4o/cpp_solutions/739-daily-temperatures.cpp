#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> dailyTemperatures(vector<int>& temperatures) {
        vector<int> result(temperatures.size(), 0);
        stack<int> stk;

        for (int i = 0; i < temperatures.size(); ++i) {
            while (!stk.empty() && temperatures[i] > temperatures[stk.top()]) {
                int idx = stk.top();
                stk.pop();
                result[idx] = i - idx;
            }
            stk.push(i);
        }

        return result;
    }
};