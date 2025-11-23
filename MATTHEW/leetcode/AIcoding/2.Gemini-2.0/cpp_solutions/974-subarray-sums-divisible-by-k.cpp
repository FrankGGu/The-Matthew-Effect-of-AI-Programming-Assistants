#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int subarraysDivByK(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        count[0] = 1;
        int sum = 0;
        int ans = 0;
        for (int num : nums) {
            sum = (sum + num) % k;
            if (sum < 0) {
                sum += k;
            }
            if (count.count(sum)) {
                ans += count[sum];
            }
            count[sum]++;
        }
        return ans;
    }
};