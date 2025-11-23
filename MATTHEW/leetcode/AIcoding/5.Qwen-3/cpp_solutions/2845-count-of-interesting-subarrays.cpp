#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countInterestingSubarrays(vector<int>& nums, int k) {
        unordered_map<long long, long long> prefixCount;
        prefixCount[0] = 1;
        long long count = 0;
        long long currentSum = 0;

        for (int num : nums) {
            currentSum += num % 2;
            if (prefixCount.find(currentSum - k) != prefixCount.end()) {
                count += prefixCount[currentSum - k];
            }
            prefixCount[currentSum]++;
        }

        return count;
    }
};