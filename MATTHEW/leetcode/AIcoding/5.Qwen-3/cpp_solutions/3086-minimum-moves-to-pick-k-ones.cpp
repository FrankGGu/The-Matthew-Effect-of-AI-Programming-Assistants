#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMovesToPickKOnes(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> ones;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 1) {
                ones.push_back(i);
            }
        }
        int m = ones.size();
        int result = INT_MAX;
        for (int i = 0; i + k - 1 < m; ++i) {
            int left = ones[i];
            int right = ones[i + k - 1];
            int mid = ones[i + (k - 1) / 2];
            int moves = 0;
            for (int j = i; j <= i + k - 1; ++j) {
                moves += abs(ones[j] - mid);
            }
            result = min(result, moves);
        }
        return result;
    }
};