#include <vector>
#include <stack>

class Solution {
public:
    int sumSubarrayMins(std::vector<int>& arr) {
        int n = arr.size();
        long long MOD = 1e9 + 7;

        std::vector<long long> left(n); // left[i] stores count of elements to the left of i (inclusive) >= arr[i]
        std::vector<long long> right(n); // right[i] stores count of elements to the right of i (inclusive) > arr[i]

        std::stack<int> st;

        // Calculate left[i]
        // For each arr[i], find the index of the previous strictly smaller element (PSE).
        // If no such element, PSE is -1.
        // left[i] = i - PSE[i]
        for (int i = 0; i < n; ++i) {
            while (!st.empty() && arr[st.top()] >= arr[i]) {
                st.pop();
            }
            left[i] = st.empty() ? (long long)i + 1 : (long long)i - st.top();
            st.push(i);
        }

        // Clear stack for next calculation
        while (!st.empty()) {
            st.pop();
        }

        // Calculate right[i]
        // For each arr[i], find the index of the next smaller or equal element (NSE).
        // If no such element, NSE is n.
        // right[i] = NSE[i] - i
        for (int i = n - 1; i >= 0; --i) {
            while (!st.empty() && arr[st.top()] > arr[i]) { // Use '>' for next smaller OR EQUAL to handle duplicates correctly
                st.pop();
            }
            right[i] = st.empty() ? (long long)n - i : (long long)st.top() - i;
            st.push(i);
        }

        long long totalSum = 0;
        for (int i = 0; i < n; ++i) {
            totalSum = (totalSum + arr[i] * left[i] % MOD * right[i] % MOD) % MOD;
        }

        return static_cast<int>(totalSum);
    }
};