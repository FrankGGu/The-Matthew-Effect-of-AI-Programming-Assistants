#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countDistinct(vector<int>& nums, int k, int p) {
        unordered_set<string> subarrays;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int count = 0;
            string subarray = "";
            for (int j = i; j < n; ++j) {
                if (nums[j] % p == 0) {
                    count++;
                }
                if (count > k) {
                    break;
                }
                if (subarray.empty()) {
                    subarray += to_string(nums[j]);
                } else {
                    subarray += "," + to_string(nums[j]);
                }
                subarrays.insert(subarray);
            }
        }
        return subarrays.size();
    }
};