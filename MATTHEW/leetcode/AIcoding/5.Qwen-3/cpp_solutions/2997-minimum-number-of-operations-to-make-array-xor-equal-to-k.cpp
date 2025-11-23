#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }
        int diff = xorSum ^ k;
        int operations = 0;
        while (diff) {
            operations += diff & 1;
            diff >>= 1;
        }
        return operations;
    }
};