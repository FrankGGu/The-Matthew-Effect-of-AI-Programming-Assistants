#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    int longestSubarray(vector<int>& nums, int limit) {
        deque<int> max_deque, min_deque;
        int left = 0, right = 0;
        int max_len = 0;

        while (right < nums.size()) {
            while (!max_deque.empty() && nums[right] > max_deque.back()) {
                max_deque.pop_back();
            }
            max_deque.push_back(nums[right]);

            while (!min_deque.empty() && nums[right] < min_deque.back()) {
                min_deque.pop_back();
            }
            min_deque.push_back(nums[right]);

            while (max_deque.front() - min_deque.front() > limit) {
                if (max_deque.front() == nums[left]) {
                    max_deque.pop_front();
                }
                if (min_deque.front() == nums[left]) {
                    min_deque.pop_front();
                }
                left++;
            }

            max_len = max(max_len, right - left + 1);
            right++;
        }

        return max_len;
    }
};