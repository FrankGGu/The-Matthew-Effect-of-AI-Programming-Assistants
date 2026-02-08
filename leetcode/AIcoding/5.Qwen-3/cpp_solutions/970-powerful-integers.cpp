#include <iostream>
#include <vector>
#include <unordered_set>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> powerfulIntegers(int x, int y, int maxSum) {
        unordered_set<int> result;
        for (int i = 0; pow(x, i) <= maxSum; ++i) {
            for (int j = 0; pow(y, j) <= maxSum; ++j) {
                int sum = pow(x, i) + pow(y, j);
                if (sum <= maxSum) {
                    result.insert(sum);
                }
            }
        }
        return vector<int>(result.begin(), result.end());
    }
};