#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxNonDecreasingSubarray(int n, vector<int>& a, vector<int>& b) {
        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < n; ++i) {
            if (a[i] >= a[i - 1] && b[i] >= b[i - 1]) {
                currentLen++;
            } else if (a[i] >= a[i - 1] || b[i] >= b[i - 1]) {
                currentLen = 2;
            } else {
                currentLen = 1;
            }
            maxLen = max(maxLen, currentLen);
        }

        return maxLen;
    }
};