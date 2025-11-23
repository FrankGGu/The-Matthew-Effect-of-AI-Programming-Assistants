#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findValidSplit(int n, vector<int>& nums) {
        vector<int> leftCount(200001, 0);
        vector<int> rightCount(200001, 0);

        for (int i = 0; i < n; ++i) {
            rightCount[nums[i]]++;
        }

        for (int i = 0; i < n; ++i) {
            if (i > 0) {
                bool valid = true;
                for (int j = 0; j <= 200000; ++j) {
                    if (leftCount[j] != rightCount[j]) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    return i - 1;
                }
            }
            leftCount[nums[i]]++;
            rightCount[nums[i]]--;
        }

        return -1;
    }
};