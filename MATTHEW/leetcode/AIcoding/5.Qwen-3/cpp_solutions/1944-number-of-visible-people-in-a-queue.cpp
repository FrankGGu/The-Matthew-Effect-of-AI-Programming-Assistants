#include <iostream>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> canSeePersonsAtFrontOfQueue(vector<int>& heights) {
        int n = heights.size();
        vector<int> result(n, 0);
        stack<int> s;

        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && heights[s.top()] < heights[i]) {
                s.pop();
                result[i]++;
            }
            if (!s.empty()) {
                result[i]++;
            }
            s.push(i);
        }

        return result;
    }
};