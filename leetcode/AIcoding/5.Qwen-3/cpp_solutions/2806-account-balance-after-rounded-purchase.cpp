#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int accountBalanceAfterRoundedPurchase(int money) {
        return money - (round(money / 10.0) * 10);
    }
};