#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxTurbulenceSize(vector<int>& arr) {
        int n = arr.size();
        if (n <= 1) return n;

        int maxLen = 1;
        int currLen = 1;

        for (int i = 1; i < n; ++i) {
            if (arr[i] > arr[i - 1]) {
                currLen = (arr[i - 1] < arr[i - 2] || i == 1) ? currLen + 1 : 1;
            } else if (arr[i] < arr[i - 1]) {
                currLen = (arr[i - 1] > arr[i - 2] || i == 1) ? currLen + 1 : 1;
            } else {
                currLen = 1;
            }
            maxLen = max(maxLen, currLen);
        }

        return maxLen;
    }
};