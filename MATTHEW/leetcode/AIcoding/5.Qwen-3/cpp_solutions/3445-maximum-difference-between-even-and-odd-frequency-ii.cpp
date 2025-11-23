#include <iostream>
#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumEvenOddDifference(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int maxDiff = INT_MIN;
        for (int i = 0; i < n; i++) {
            if (freq[nums[i]] % 2 == 0) {
                for (int j = 0; j < n; j++) {
                    if (i != j && freq[nums[j]] % 2 == 1) {
                        maxDiff = max(maxDiff, abs(nums[i] - nums[j]));
                    }
                }
            }
        }

        return maxDiff;
    }
};