#include <vector>

using namespace std;

class Solution {
public:
    vector<long long> handleQuery(vector<int>& nums1, vector<int>& nums2, vector<vector<int>>& queries) {
        int n = nums1.size();
        long long sum2 = 0;
        for (int num : nums2) {
            sum2 += num;
        }

        vector<long long> result;
        for (auto& query : queries) {
            int type = query[0];
            if (type == 1) {
                int l = query[1];
                int r = query[2];
                for (int i = l; i <= r; ++i) {
                    nums1[i] = 1 - nums1[i];
                }
            } else if (type == 2) {
                int p = query[1];
                long long sum1 = 0;
                for (int num : nums1) {
                    sum1 += num;
                }
                sum2 += sum1 * p;
            } else {
                result.push_back(sum2);
            }
        }

        return result;
    }
};