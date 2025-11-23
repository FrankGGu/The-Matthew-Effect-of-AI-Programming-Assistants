#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int pos = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == k) {
                pos = i;
                break;
            }
        }

        unordered_map<int, int> count;
        count[0] = 1;
        int balance = 0;
        int res = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] < k) {
                --balance;
            } else if (nums[i] > k) {
                ++balance;
            }

            if (i < pos) {
                ++count[balance];
            } else {
                res += count[balance] + count[balance - 1];
            }
        }

        return res;
    }
};