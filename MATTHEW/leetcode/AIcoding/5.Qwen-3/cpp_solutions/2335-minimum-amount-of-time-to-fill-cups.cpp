#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int fillCups(vector<int>& amount) {
        int maxVal = *max_element(amount.begin(), amount.end());
        int sum = 0;
        for (int a : amount) {
            sum += a;
        }
        return max(maxVal, (sum + 1) / 2);
    }
};