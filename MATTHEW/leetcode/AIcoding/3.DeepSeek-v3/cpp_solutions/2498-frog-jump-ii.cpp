class Solution {
public:
    int maxJump(vector<int>& stones) {
        int n = stones.size();
        if (n == 2) {
            return stones[1] - stones[0];
        }
        int max_cost = 0;
        for (int i = 2; i < n; ++i) {
            max_cost = max(max_cost, stones[i] - stones[i - 2]);
        }
        return max_cost;
    }
};