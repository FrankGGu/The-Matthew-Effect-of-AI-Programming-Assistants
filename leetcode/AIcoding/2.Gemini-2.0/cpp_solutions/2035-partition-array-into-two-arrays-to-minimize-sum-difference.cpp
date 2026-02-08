#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumDifference(vector<int>& nums) {
        int n = nums.size();
        int m = n / 2;
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        vector<vector<int>> left(m + 1);
        vector<vector<int>> right(m + 1);

        function<void(int, int, int, int, vector<int>&, vector<vector<int>>&)> generateSubsets = 
            [&](int index, int count, int sum, int end, vector<int>& arr, vector<vector<int>>& subsets) {
            if (index == end) {
                subsets[count].push_back(sum);
                return;
            }
            generateSubsets(index + 1, count, sum, end, arr, subsets);
            generateSubsets(index + 1, count + 1, sum + arr[index], end, arr, subsets);
        };

        vector<int> leftHalf(nums.begin(), nums.begin() + m);
        vector<int> rightHalf(nums.begin() + m, nums.end());

        generateSubsets(0, 0, 0, m, leftHalf, left);
        generateSubsets(0, 0, 0, m, rightHalf, right);

        for (int i = 0; i <= m; ++i) {
            sort(right[i].begin(), right[i].end());
        }

        int minDiff = INT_MAX;
        for (int i = 0; i <= m; ++i) {
            for (int leftSum : left[i]) {
                int target = (totalSum - 2 * leftSum) / 2;
                int j = m - i;
                auto it = lower_bound(right[j].begin(), right[j].end(), target);
                if (it != right[j].end()) {
                    minDiff = min(minDiff, abs(totalSum - 2 * (leftSum + *it)));
                }
                if (it != right[j].begin()) {
                    it--;
                    minDiff = min(minDiff, abs(totalSum - 2 * (leftSum + *it)));
                }
            }
        }

        return minDiff;
    }
};