#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> resultsArray(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            result[i] = 0;
        }
        for (int i = 0; i < n; ++i) {
            int sum = 0;
            int count = 0;
            for (int j = max(0, i - k); j <= min(n - 1, i + k); ++j) {
                sum += nums[j];
                count++;
            }
            result[i] = sum / count;
        }
        return result;
    }
};