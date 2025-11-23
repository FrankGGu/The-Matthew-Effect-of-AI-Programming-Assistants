#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int maxNumberofWaysToPartition(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        map<long long, int> leftCount;
        leftCount[0] = 1;
        long long total = prefix[n];
        int result = 0;

        for (int i = 0; i < n - 1; ++i) {
            long long leftSum = prefix[i + 1];
            long long rightSum = total - leftSum;
            long long target = leftSum - rightSum;
            if (leftCount.find(target) != leftCount.end()) {
                result += leftCount[target];
            }
            leftCount[prefix[i + 1]]++;
        }

        return result;
    }
};