#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minElement(vector<int>& nums) {
        for (int i = 0; i < nums.size(); ++i) {
            int sum = 0;
            int num = nums[i];
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            nums[i] = sum;
        }
        return *min_element(nums.begin(), nums.end());
    }
};