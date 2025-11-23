#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int closestToZero(vector<int>& nums) {
        int closest = nums[0];
        for (int num : nums) {
            if (abs(num) < abs(closest)) {
                closest = num;
            } else if (abs(num) == abs(closest) && num > closest) {
                closest = num;
            }
        }
        return closest;
    }
};