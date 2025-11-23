#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> distinct;
        for (int num : nums) {
            bool found = false;
            for (int d : distinct) {
                if (d == num) {
                    found = true;
                    break;
                }
            }
            if (!found) {
                distinct.push_back(num);
            }
        }

        int distinct_count = distinct.size();
        if (distinct_count <= k) {
            return 0;
        }

        int ans = distinct_count - k;
        return ans;
    }
};