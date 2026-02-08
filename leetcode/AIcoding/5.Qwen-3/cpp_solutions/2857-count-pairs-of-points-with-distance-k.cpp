#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPairs(vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        int count = 0;
        for (int num : nums) {
            int target = num ^ k;
            count += freq[target];
            freq[num]++;
        }
        return count;
    }
};