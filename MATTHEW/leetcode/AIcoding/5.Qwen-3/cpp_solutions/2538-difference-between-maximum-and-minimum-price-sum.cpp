#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int differenceSum(vector<int>& price) {
        int minPrice = INT_MAX;
        int maxPrice = INT_MIN;
        for (int p : price) {
            minPrice = min(minPrice, p);
            maxPrice = max(maxPrice, p);
        }
        return maxPrice - minPrice;
    }
};