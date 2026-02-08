#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSubarray(vector<int>& nums) {
        int max_and = 0;
        for (int num : nums) {
            max_and = max(max_and, num);
        }

        int max_len = 0;
        int current_len = 0;
        for (int num : nums) {
            if (num == max_and) {
                current_len++;
                max_len = max(max_len, current_len);
            } else {
                current_len = 0;
            }
        }

        return max_len;
    }
};