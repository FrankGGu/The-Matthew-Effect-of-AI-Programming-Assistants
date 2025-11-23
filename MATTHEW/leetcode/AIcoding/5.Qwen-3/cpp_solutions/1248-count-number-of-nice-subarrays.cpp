#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfNiceSubarrays(vector<int>& nums, int k) {
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        int count = 0;
        int prefixSum = 0;

        for (int num : nums) {
            prefixSum += num % 2;
            if (prefixCount.find(prefixSum - k) != prefixCount.end()) {
                count += prefixCount[prefixSum - k];
            }
            prefixCount[prefixSum]++;
        }

        return count;
    }
};