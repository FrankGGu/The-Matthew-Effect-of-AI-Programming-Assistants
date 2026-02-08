#include <vector>
#include <stack>
#include <algorithm>

using namespace std;

long long beautifulTowers(vector<int>& maxHeights) {
    int n = maxHeights.size();
    vector<long long> left(n, 0), right(n, 0);
    stack<int> st;

    for (int i = 0; i < n; ++i) {
        while (!st.empty() && maxHeights[st.top()] > maxHeights[i]) {
            st.pop();
        }
        if (st.empty()) {
            left[i] = (long long)(i + 1) * maxHeights[i];
        } else {
            left[i] = left[st.top()] + (long long)(i - st.top()) * maxHeights[i];
        }
        st.push(i);
    }

    while (!st.empty()) {
        st.pop();
    }

    for (int i = n - 1; i >= 0; --i) {
        while (!st.empty() && maxHeights[st.top()] > maxHeights[i]) {
            st.pop();
        }
        if (st.empty()) {
            right[i] = (long long)(n - i) * maxHeights[i];
        } else {
            right[i] = right[st.top()] + (long long)(st.top() - i) * maxHeights[i];
        }
        st.push(i);
    }

    long long ans = 0;
    for (int i = 0; i < n; ++i) {
        ans = max(ans, left[i] + right[i] - maxHeights[i]);
    }

    return ans;
}