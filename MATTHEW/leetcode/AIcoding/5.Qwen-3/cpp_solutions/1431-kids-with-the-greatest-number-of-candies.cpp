#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> kidsWithCandies(int n, vector<int>& candies) {
        int maxCandies = 0;
        for (int i = 0; i < n; i++) {
            if (candies[i] > maxCandies) {
                maxCandies = candies[i];
            }
        }
        vector<bool> result(n, false);
        for (int i = 0; i < n; i++) {
            if (candies[i] + n >= maxCandies) {
                result[i] = true;
            }
        }
        return result;
    }
};