#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxAbsValExpr(vector<int>& arr1, vector<int>& arr2) {
        int n = arr1.size();
        int maxVal = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int val = abs(arr1[i] - arr1[j]) + abs(arr2[i] - arr2[j]);
                maxVal = max(maxVal, val);
            }
        }

        return maxVal;
    }
};