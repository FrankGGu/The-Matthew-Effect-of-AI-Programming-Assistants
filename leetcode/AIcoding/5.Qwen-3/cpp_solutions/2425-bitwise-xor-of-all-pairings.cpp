#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int xorAllNums(vector<int>& nums1, vector<int>& nums2) {
        int result = 0;
        for (int num : nums1) {
            for (int num2 : nums2) {
                result ^= (num ^ num2);
            }
        }
        return result;
    }
};