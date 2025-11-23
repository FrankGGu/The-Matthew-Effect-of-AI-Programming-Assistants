#include <vector>
#include <stack>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumSumOfHeights(vector<int>& maxHeights) {
        int n = maxHeights.size();
        vector<long long> left(n), right(n);
        stack<int> st;

        for (int i = 0; i < n; ++i) {
            while (!st.empty() && maxHeights[st.top()] > maxHeights[i]) {
                st.pop();
            }
            if (st.empty()) {
                left[i] = (long long)maxHeights[i] * (i + 1);
            } else {
                left[i] = left[st.top()] + (long long)maxHeights[i] * (i - st.top());
            }
            st.push(i);
        }

        st = stack<int>();
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && maxHeights[st.top()] > maxHeights[i]) {
                st.pop();
            }
            if (st.empty()) {
                right[i] = (long long)maxHeights[i] * (n - i);
            } else {
                right[i] = right[st.top()] + (long long)maxHeights[i] * (st.top() - i);
            }
            st.push(i);
        }

        long long res = 0;
        for (int i = 0; i < n; ++i) {
            res = max(res, left[i] + right[i] - maxHeights[i]);
        }
        return res;
    }
};