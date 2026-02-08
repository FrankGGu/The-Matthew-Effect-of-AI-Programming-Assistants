#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumAddedCoins(vector<int>& coins, int target) {
        sort(coins.begin(), coins.end());
        int added_coins = 0;
        long long current_reach = 0;
        int coin_index = 0;

        while (current_reach < target) {
            if (coin_index < coins.size() && coins[coin_index] <= current_reach + 1) {
                current_reach += coins[coin_index];
                coin_index++;
            } else {
                added_coins++;
                current_reach += current_reach + 1;
            }
        }

        return added_coins;
    }
};