#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>

using namespace std;

class Solution {
private:
    vector<int> nums;
    int n;
public:
    Solution(vector<int>& nums) {
        this->nums = nums;
        n = nums.size();
        srand(time(0));
    }

    int pick(int target) {
        int count = 0;
        int index = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == target) {
                count++;
                if (rand() % count == 0) {
                    index = i;
                }
            }
        }
        return index;
    }
};