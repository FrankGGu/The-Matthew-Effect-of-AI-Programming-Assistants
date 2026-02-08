#include <vector>

using namespace std;

class Solution {
public:
    vector<int> sumEvenAfterQueries(vector<int>& nums, vector<vector<int>>& queries) {
        int evenSum = 0;
        for (int num : nums) {
            if (num % 2 == 0) {
                evenSum += num;
            }
        }

        vector<int> result;
        for (auto& query : queries) {
            int val = query[0];
            int index = query[1];

            if (nums[index] % 2 == 0) {
                evenSum -= nums[index];
            }

            nums[index] += val;

            if (nums[index] % 2 == 0) {
                evenSum += nums[index];
            }

            result.push_back(evenSum);
        }

        return result;
    }
};