#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int k_index = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == k) {
                k_index = i;
                break;
            }
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                vector<int> subarray;
                for (int l = i; l <= j; ++l) {
                    subarray.push_back(nums[l]);
                }

                vector<int> sorted_subarray = subarray;
                sort(sorted_subarray.begin(), sorted_subarray.end());
                int median_index = (sorted_subarray.size() - 1) / 2;
                if (sorted_subarray[median_index] == k) {
                    count++;
                }
            }
        }

        return count;
    }
};