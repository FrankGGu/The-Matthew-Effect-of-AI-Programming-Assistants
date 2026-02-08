#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int distMoney(int money, int children) {
        if (children > money) return 0;
        if (children == 1) return money >= 1 ? 1 : 0;

        int total = 0;
        for (int i = 0; i < children; ++i) {
            int give = min(9, money - (children - i - 1));
            money -= give;
            total++;
            if (give == 9 && money == 0) return total;
            if (give < 9 && money == 0) return total - 1;
        }
        return total;
    }
};