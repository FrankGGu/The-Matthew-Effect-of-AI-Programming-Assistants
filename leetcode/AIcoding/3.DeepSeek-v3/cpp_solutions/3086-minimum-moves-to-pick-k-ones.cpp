class Solution {
public:
    long long minimumMoves(vector<int>& nums, int k, int maxChanges) {
        vector<int> ones;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ones.push_back(i);
            }
        }
        int m = ones.size();
        vector<long long> prefix(m + 1, 0);
        for (int i = 0; i < m; ++i) {
            prefix[i + 1] = prefix[i] + ones[i];
        }

        long long res = LLONG_MAX;
        int maxAdjacent = min(k, maxChanges + 1);
        for (int adjacent = 0; adjacent <= maxAdjacent; ++adjacent) {
            if (adjacent > m) continue;
            int changes = k - adjacent;
            if (changes < 0 || changes > maxChanges) continue;
            if (changes > 0 && changes > maxChanges) continue;

            for (int i = 0; i + adjacent <= m; ++i) {
                int j = i + adjacent;
                int mid = (i + j) / 2;
                long long left = ones[mid] * (mid - i) - (prefix[mid] - prefix[i]);
                long long right = (prefix[j] - prefix[mid]) - ones[mid] * (j - mid);
                long long total = left + right;
                if (changes > 0) {
                    int leftPos = i > 0 ? ones[i - 1] : -1e6;
                    int rightPos = j < m ? ones[j] : 1e6;
                    long long extra = min(ones[i] - leftPos, rightPos - ones[j - 1]);
                    total += 2 * changes * (changes + 1) / 2;
                }
                res = min(res, total);
            }
        }
        return res;
    }
};