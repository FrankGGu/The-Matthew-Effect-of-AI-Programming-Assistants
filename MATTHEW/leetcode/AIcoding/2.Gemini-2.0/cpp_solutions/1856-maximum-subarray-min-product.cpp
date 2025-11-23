#include <vector>
#include <stack>

using namespace std;

int maxSubarrayMinProduct(vector<int>& nums) {
    int n = nums.size();
    vector<long long> prefixSum(n + 1, 0);
    for (int i = 0; i < n; ++i) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    vector<int> left(n), right(n);
    stack<int> st;

    for (int i = 0; i < n; ++i) {
        while (!st.empty() && nums[st.top()] >= nums[i]) {
            st.pop();
        }
        left[i] = st.empty() ? 0 : st.top() + 1;
        st.push(i);
    }

    while (!st.empty()) st.pop();

    for (int i = n - 1; i >= 0; --i) {
        while (!st.empty() && nums[st.top()] > nums[i]) {
            st.pop();
        }
        right[i] = st.empty() ? n - 1 : st.top() - 1;
        st.push(i);
    }

    long long maxProduct = 0;
    for (int i = 0; i < n; ++i) {
        long long sum = prefixSum[right[i] + 1] - prefixSum[left[i]];
        maxProduct = max(maxProduct, (long long)nums[i] * sum);
    }

    return (int)(maxProduct % 1000000007);
}