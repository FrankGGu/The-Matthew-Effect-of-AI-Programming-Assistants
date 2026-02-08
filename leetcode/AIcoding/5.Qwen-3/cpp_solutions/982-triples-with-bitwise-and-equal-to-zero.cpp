#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numTriplets(vector<int>& nums) {
        int n = nums.size();
        int result = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                for (int k = j + 1; k < n; k++) {
                    if ((nums[i] & nums[j]) == 0 && (nums[i] & nums[k]) == 0 && (nums[j] & nums[k]) == 0) {
                        result++;
                    }
                }
            }
        }
        return result;
    }
};