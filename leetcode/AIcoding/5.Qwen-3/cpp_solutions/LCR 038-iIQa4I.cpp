#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> dailyTemperatures(vector<int>& temperatures) {
        int n = temperatures.size();
        vector<int> result(n, 0);
        stack<int> indexStack;

        for (int i = 0; i < n; ++i) {
            while (!indexStack.empty() && temperatures[i] > temperatures[indexStack.top()]) {
                int prevIndex = indexStack.top();
                result[prevIndex] = i - prevIndex;
                indexStack.pop();
            }
            indexStack.push(i);
        }

        return result;
    }
};