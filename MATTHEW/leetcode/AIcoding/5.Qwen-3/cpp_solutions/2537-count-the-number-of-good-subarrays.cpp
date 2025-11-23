#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfSubarrays(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        count[0] = 1;
        int res = 0, even = 0;
        for (int num : nums) {
            even += num % 2;
            res += count[even - k];
            count[even]++;
        }
        return res;
    }
};