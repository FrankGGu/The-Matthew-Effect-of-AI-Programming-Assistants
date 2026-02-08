#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int beautifulSubarrays(vector<int>& nums) {
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;
        int count = 0;
        int xorSum = 0;

        for (int num : nums) {
            xorSum ^= num;
            count += prefixCount[xorSum];
            prefixCount[xorSum]++;
        }

        return count;
    }
};