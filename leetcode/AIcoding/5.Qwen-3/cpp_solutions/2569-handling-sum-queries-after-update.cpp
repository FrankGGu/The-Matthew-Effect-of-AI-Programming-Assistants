#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<long long> handleSumQueries(vector<int>& nums, vector<vector<int>>& queries) {
        map<int, long long> prefixSum;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            prefixSum[i] = (i == 0 ? 0 : prefixSum[i - 1]) + nums[i];
        }

        vector<long long> result;
        for (auto& q : queries) {
            int index = q[0];
            int val = q[1];
            int left = q[2];
            int right = q[3];

            if (index >= 0 && index < n) {
                long long prev = nums[index];
                nums[index] += val;
                long long diff = val;

                for (int i = index; i < n; ++i) {
                    prefixSum[i] += diff;
                }
            }

            long long sum = prefixSum[right] - (left > 0 ? prefixSum[left - 1] : 0);
            result.push_back(sum);
        }

        return result;
    }
};