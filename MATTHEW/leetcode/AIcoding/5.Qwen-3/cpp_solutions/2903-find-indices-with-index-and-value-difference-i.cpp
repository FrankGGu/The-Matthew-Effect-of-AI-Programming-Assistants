#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findIndices(int valueDifference, int indexDifference) {
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (abs(nums[i] - nums[j]) == valueDifference && abs(i - j) == indexDifference) {
                    return {i, j};
                }
            }
        }
        return {-1, -1};
    }
};