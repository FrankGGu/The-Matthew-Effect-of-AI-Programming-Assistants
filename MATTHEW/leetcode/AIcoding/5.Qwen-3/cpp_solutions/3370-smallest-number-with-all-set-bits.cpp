#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int smallestNumber(int[] nums) {
        int result = 0;
        for (int num : nums) {
            result |= num;
        }
        return result;
    }
};