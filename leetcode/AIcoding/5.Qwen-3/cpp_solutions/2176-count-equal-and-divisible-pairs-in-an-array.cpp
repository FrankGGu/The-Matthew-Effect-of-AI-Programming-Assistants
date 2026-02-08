#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPairs(int n, vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] % k == 0) {
                count += freq[nums[i]];
            }
            freq[nums[i]]++;
        }
        return count;
    }
};