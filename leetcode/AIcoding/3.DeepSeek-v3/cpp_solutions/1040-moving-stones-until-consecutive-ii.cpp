class Solution {
public:
    vector<int> numMovesStonesII(vector<int>& stones) {
        sort(stones.begin(), stones.end());
        int n = stones.size();
        int max_moves = max(stones[n-1] - stones[1] - n + 2, stones[n-2] - stones[0] - n + 2);
        int min_moves = n;
        int j = 0;
        for (int i = 0; i < n; ++i) {
            while (j + 1 < n && stones[j + 1] - stones[i] < n) {
                ++j;
            }
            int cost = n - (j - i + 1);
            if (j - i + 1 == n - 1 && stones[j] - stones[i] + 1 == n - 1) {
                cost = 2;
            }
            min_moves = min(min_moves, cost);
        }
        return {min_moves, max_moves};
    }
};