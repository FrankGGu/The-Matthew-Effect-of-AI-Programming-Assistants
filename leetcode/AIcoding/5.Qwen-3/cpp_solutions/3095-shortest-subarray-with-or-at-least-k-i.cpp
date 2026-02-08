#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int shortestSubarray(int n, vector<int>& nums, int k) {
        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            int or_val = 0;
            for (int j = i; j < n; ++j) {
                or_val |= nums[j];
                if (or_val >= k) {
                    result = min(result, j - i + 1);
                    break;
                }
            }
        }
        return result;
    }
};