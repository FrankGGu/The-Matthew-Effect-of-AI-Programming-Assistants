#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countCompleteSubarrays(vector<int>& nums) {
        unordered_map<int, int> freq;
        int unique = 0;
        for (int num : nums) {
            if (freq[num] == 0) {
                unique++;
            }
            freq[num]++;
        }

        int left = 0;
        int result = 0;
        unordered_map<int, int> currentFreq;

        for (int right = 0; right < nums.size(); ++right) {
            currentFreq[nums[right]]++;

            while (currentFreq.size() == unique) {
                result++;
                currentFreq[nums[left]]--;
                if (currentFreq[nums[left]] == 0) {
                    currentFreq.erase(nums[left]);
                }
                left++;
            }
        }

        return result;
    }
};