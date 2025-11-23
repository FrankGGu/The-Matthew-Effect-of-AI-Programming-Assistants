#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minDeletionsToRemoveDuplicates(vector<int>& nums) {
        int n = nums.size();
        vector<int> freq(1001, 0);
        for (int num : nums) {
            freq[num]++;
        }
        int deletions = 0;
        for (int i = 0; i < 1001; ++i) {
            if (freq[i] > 1) {
                deletions += freq[i] - 1;
            }
        }
        return deletions;
    }
};