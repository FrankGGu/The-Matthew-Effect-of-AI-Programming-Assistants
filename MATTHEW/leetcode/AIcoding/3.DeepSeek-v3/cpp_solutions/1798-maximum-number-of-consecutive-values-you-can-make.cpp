class Solution {
public:
    int getMaximumConsecutive(vector<int>& coins) {
        sort(coins.begin(), coins.end());
        int max_val = 0;
        for (int coin : coins) {
            if (coin > max_val + 1) {
                break;
            }
            max_val += coin;
        }
        return max_val + 1;
    }
};