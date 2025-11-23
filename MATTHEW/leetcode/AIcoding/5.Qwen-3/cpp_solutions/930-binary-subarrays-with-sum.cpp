#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numSubarraysWithSum(vector<int>& nums, int k) {
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        int currentSum = 0;
        int count = 0;

        for (int num : nums) {
            currentSum += num;
            if (prefixCount.find(currentSum - k) != prefixCount.end()) {
                count += prefixCount[currentSum - k];
            }
            prefixCount[currentSum]++;
        }

        return count;
    }
};