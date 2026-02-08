#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    long long continuousSubarrays(vector<int>& nums) {
        long long count = 0;
        deque<int> max_deque;
        deque<int> min_deque;
        int left = 0;
        for (int right = 0; right < nums.size(); ++right) {
            while (!max_deque.empty() && nums[max_deque.back()] <= nums[right]) {
                max_deque.pop_back();
            }
            max_deque.push_back(right);

            while (!min_deque.empty() && nums[min_deque.back()] >= nums[right]) {
                min_deque.pop_back();
            }
            min_deque.push_back(right);

            while (nums[max_deque.front()] - nums[min_deque.front()] > 2) {
                if (max_deque.front() == left) {
                    max_deque.pop_front();
                }
                if (min_deque.front() == left) {
                    min_deque.pop_front();
                }
                left++;
            }

            count += (right - left + 1);
        }
        return count;
    }
};