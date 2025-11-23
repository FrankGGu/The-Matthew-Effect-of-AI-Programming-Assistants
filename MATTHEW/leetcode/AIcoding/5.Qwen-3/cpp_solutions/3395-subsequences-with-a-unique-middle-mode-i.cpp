#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countSubseqWithUniqueMiddle(const vector<int>& nums) {
        int n = nums.size();
        int result = 0;

        for (int i = 0; i < n; ++i) {
            unordered_map<int, int> freq;
            int maxFreq = 0;
            int mode = -1;
            int count = 0;

            for (int j = i; j < n; ++j) {
                freq[nums[j]]++;
                if (freq[nums[j]] > maxFreq) {
                    maxFreq = freq[nums[j]];
                    mode = nums[j];
                } else if (freq[nums[j]] == maxFreq) {
                    mode = -1;
                }

                if (mode != -1) {
                    result++;
                }
            }
        }

        return result;
    }
};