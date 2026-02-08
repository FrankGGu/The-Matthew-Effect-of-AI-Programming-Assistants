#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxSubarrays(vector<int>& nums) {
        int count = 0;
        int current = 0;
        for (int num : nums) {
            current |= num;
            if (current == 0) {
                count++;
                current = 0;
            }
        }
        return count > 0 ? count : 1;
    }
};