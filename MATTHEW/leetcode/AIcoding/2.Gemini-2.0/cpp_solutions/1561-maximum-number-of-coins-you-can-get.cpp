#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxCoins(vector<int>& piles) {
        sort(piles.begin(), piles.end());
        int n = piles.size();
        int coins = 0;
        for (int i = n - 2; i >= n / 3; i -= 2) {
            coins += piles[i];
        }
        return coins;
    }
};