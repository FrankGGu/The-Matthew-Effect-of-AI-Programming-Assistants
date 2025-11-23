#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minArrayLength(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        int result = 0;
        for (auto& [num, freq] : count) {
            if (freq % k == 0) {
                result += freq / k;
            } else {
                result += freq / k + 1;
            }
        }
        return result;
    }
};