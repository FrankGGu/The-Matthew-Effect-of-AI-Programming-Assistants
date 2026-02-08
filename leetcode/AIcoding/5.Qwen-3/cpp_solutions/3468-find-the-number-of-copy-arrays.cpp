#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfCopyArrays(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        int result = 1;
        for (auto& [key, count] : freq) {
            result *= (count + 1);
        }
        return result - 1;
    }
};