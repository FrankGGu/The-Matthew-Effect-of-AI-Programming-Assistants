class Solution {
public:
    int maxJump(vector<int>& stones) {
        int maxJump = 0;
        for (int i = 1; i < stones.size(); i++) {
            maxJump = max(maxJump, stones[i] - stones[i - 1]);
        }
        return maxJump;
    }
};