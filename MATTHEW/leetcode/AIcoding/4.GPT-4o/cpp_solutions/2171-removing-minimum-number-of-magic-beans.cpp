class Solution {
public:
    long long minimumRemoval(vector<int>& beans) {
        long long totalBeans = accumulate(beans.begin(), beans.end(), 0LL);
        long long minRemoval = LLONG_MAX;
        int n = beans.size();

        sort(beans.begin(), beans.end());

        for (int i = 0; i < n; ++i) {
            long long currentRemoval = totalBeans - (long long)beans[i] * (n - i);
            minRemoval = min(minRemoval, currentRemoval);
        }

        return minRemoval;
    }
};