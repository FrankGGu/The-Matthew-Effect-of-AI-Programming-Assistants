#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int waysToPartition(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> prefix(n, 0);
        prefix[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            prefix[i] = prefix[i - 1] + nums[i];
        }

        unordered_map<long long, int> left, right;
        for (int i = 0; i < n - 1; ++i) {
            right[prefix[i]]++;
        }

        long long total = prefix.back();
        int res = 0;
        if (total % 2 == 0) {
            res = right[total / 2];
        }

        for (int i = 0; i < n; ++i) {
            long long new_total = total - nums[i] + k;
            if (new_total % 2 == 0) {
                long long half = new_total / 2;
                int cnt = left[half] + right[half];
                if (i > 0 && prefix[i - 1] == half) {
                    cnt--;
                }
                res = max(res, cnt);
            }

            if (i < n - 1) {
                left[prefix[i]]++;
                right[prefix[i]]--;
                if (right[prefix[i]] == 0) {
                    right.erase(prefix[i]);
                }
            }
        }

        return res;
    }
};