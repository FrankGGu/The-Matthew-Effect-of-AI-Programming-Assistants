#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int buyCandies(vector<int>& prices, int money) {
        sort(prices.begin(), prices.end());
        int total = 0;
        for (int i = 0; i < prices.size(); ++i) {
            if (total + prices[i] > money) {
                return -1;
            }
            total += prices[i];
        }
        return total;
    }
};