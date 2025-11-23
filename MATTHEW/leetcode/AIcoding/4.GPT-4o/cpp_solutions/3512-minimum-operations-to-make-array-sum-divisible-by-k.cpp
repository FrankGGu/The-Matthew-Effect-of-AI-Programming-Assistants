class Solution {
public:
    int minOperations(vector<int>& A, int K) {
        int n = A.size();
        int sum = accumulate(A.begin(), A.end(), 0);
        int remainder = sum % K;

        if (remainder == 0) return 0;

        unordered_map<int, int> count;
        for (int num : A) {
            int mod = (num % K + K) % K;
            count[mod]++;
        }

        int ops = INT_MAX;
        for (int num : A) {
            int mod = (num % K + K) % K;
            int needed = (remainder + K - mod) % K;

            if (count.count(needed)) {
                ops = min(ops, count[needed]);
            }
        }

        return ops == INT_MAX ? -1 : ops;
    }
};