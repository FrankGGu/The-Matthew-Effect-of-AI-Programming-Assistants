class Solution {
public:
    int shortestSubarray(vector<int>& A, int K) {
        int n = A.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] | A[i];
        }

        int result = INT_MAX;
        deque<int> dq;
        for (int i = 0; i <= n; ++i) {
            while (!dq.empty() && prefix[i] >= K) {
                result = min(result, i - dq.front());
                dq.pop_front();
            }
            while (!dq.empty() && prefix[dq.back()] <= prefix[i]) {
                dq.pop_back();
            }
            dq.push_back(i);
        }

        return result == INT_MAX ? -1 : result;
    }
};