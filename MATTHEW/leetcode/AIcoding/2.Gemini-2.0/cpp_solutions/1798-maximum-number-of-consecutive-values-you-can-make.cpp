#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getMaximumConsecutive(vector<int>& coins) {
        sort(coins.begin(), coins.end());
        int reachable = 1;
        for (int coin : coins) {
            if (coin <= reachable) {
                reachable += coin;
            } else {
                break;
            }
        }
        return reachable;
    }
};