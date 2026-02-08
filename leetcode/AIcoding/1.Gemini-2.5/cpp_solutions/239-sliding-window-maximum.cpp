#include <vector>
#include <deque>
#include <algorithm>

class Solution {
public:
    std::vector<int> maxSlidingWindow(std::vector<int>& nums, int k) {
        std::vector<int> result;
        std::deque<int> dq; // Stores indices

        for (int i = 0; i < nums.size(); ++i) {
            // Remove elements from the front of the deque if they are out of the current window
            if (!dq.empty() && dq.front() == i - k) {
                dq.pop_front();
            }

            // Remove elements from the back of the deque that are smaller than or equal to the current element
            // This maintains the decreasing order of elements in the deque
            while (!dq.empty() && nums[dq.back()] <= nums[i]) {
                dq.pop_back();
            }

            // Add the current element's index to the back of the deque
            dq.push_back(i);

            // If the window has fully formed (i.e., i + 1 >= k),
            // the front of the deque contains the index of the maximum element in the current window
            if (i >= k - 1) {
                result.push_back(nums[dq.front()]);
            }
        }

        return result;
    }
};