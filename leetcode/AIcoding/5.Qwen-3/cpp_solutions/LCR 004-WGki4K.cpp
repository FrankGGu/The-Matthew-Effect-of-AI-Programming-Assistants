#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int singleNumber(vector<int>& nums) {
        int result = 0;
        for (int i = 0; i < 32; ++i) {
            int bitSum = 0;
            for (int num : nums) {
                bitSum += (num >> i) & 1;
            }
            if (bitSum % 3 != 0) {
                result |= (bitSum % 3) << i;
            }
        }
        return result;
    }
};