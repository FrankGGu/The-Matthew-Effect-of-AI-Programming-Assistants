#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumElementAfterDecreasing(const vector<int>& arr) {
        int n = arr.size();
        vector<int> sortedArr = arr;
        sort(sortedArr.begin(), sortedArr.end());
        sortedArr[0] = 1;
        for (int i = 1; i < n; ++i) {
            if (sortedArr[i] > sortedArr[i - 1] + 1) {
                sortedArr[i] = sortedArr[i - 1] + 1;
            }
        }
        return sortedArr[n - 1];
    }
};