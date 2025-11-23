#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> canSeePersonsCount(vector<int>& heights) {
        int n = heights.size();
        vector<int> result(n, 0);
        stack<int> st;

        for (int i = n - 1; i >= 0; --i) {
            int count = 0;
            while (!st.empty() && heights[i] > heights[st.top()]) {
                st.pop();
                count++;
            }
            if (!st.empty()) {
                count++;
            }
            result[i] = count;
            st.push(i);
        }

        return result;
    }
};