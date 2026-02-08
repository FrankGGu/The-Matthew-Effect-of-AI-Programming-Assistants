#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumCoins(vector<int>& coins, int target) {
        sort(coins.begin(), coins.end());
        int res = 0;
        int curr = 1;
        int i = 0;
        while (curr <= target) {
            if (i < coins.size() && coins[i] <= curr) {
                curr += coins[i];
                i++;
            } else {
                curr += curr;
                res++;
            }
        }
        return res;
    }
};