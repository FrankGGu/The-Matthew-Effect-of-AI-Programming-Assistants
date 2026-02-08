#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int optimalPurchase(vector<int>& prices, int money) {
        sort(prices.begin(), prices.end());
        int count = 0;
        for (int price : prices) {
            if (money >= price) {
                money -= price;
                count++;
            } else {
                break;
            }
        }
        return count;
    }
};