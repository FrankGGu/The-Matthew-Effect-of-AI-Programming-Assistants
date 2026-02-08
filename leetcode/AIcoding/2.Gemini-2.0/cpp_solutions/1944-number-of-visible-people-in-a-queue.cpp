#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> canSeePersonsCount(vector<int>& heights) {
        int n = heights.size();
        vector<int> result(n, 0);
        stack<int> s;
        for (int i = n - 1; i >= 0; --i) {
            int count = 0;
            while (!s.empty() && heights[i] > heights[s.top()]) {
                s.pop();
                count++;
            }
            if (!s.empty()) {
                count++;
            }
            result[i] = count;
            s.push(i);
        }
        return result;
    }
};