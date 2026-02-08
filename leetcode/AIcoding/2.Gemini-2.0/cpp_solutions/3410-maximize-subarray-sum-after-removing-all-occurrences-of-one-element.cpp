#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeSum(vector<int>& nums, int k) {
        int n = nums.size();
        int maxSum = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] == k) {
                vector<int> tempNums;
                for (int j = 0; j < n; ++j) {
                    if (nums[j] != k) {
                        tempNums.push_back(nums[j]);
                    }
                }

                int currentSum = 0;
                int maxCurrentSum = 0;
                for (int num : tempNums) {
                    currentSum = max(num, currentSum + num);
                    maxCurrentSum = max(maxCurrentSum, currentSum);
                }

                maxSum = max(maxSum, maxCurrentSum);
            }
        }

        vector<int> tempNums;
        for (int j = 0; j < n; ++j) {
                tempNums.push_back(nums[j]);
        }

        int currentSum = 0;
        int maxCurrentSum = 0;
        for (int num : tempNums) {
            currentSum = max(num, currentSum + num);
            maxCurrentSum = max(maxCurrentSum, currentSum);
        }

        maxSum = max(maxSum, maxCurrentSum);

        vector<int> emptyVec;
        int emptySum = 0;
        int maxEmptySum = 0;
        for (int num : emptyVec) {
            emptySum = max(num, emptySum + num);
            maxEmptySum = max(maxEmptySum, emptySum);
        }
        maxSum = max(maxSum, maxEmptySum);

        return maxSum;
    }
};