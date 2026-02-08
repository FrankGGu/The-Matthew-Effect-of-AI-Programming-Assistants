class Solution {
public:
    int minimumAddedCoins(vector<int>& coins, int target) {
        sort(coins.begin(), coins.end());
        int res = 0;
        long max_reach = 0;
        int i = 0;
        int n = coins.size();

        while (max_reach < target) {
            if (i < n && coins[i] <= max_reach + 1) {
                max_reach += coins[i];
                i++;
            } else {
                max_reach += max_reach + 1;
                res++;
            }
        }

        return res;
    }
};