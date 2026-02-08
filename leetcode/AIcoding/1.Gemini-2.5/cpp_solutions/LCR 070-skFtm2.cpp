#include <vector>

class Solution {
public:
    int singleNonDuplicate(std::vector<int>& nums) {
        int low = 0;
        int high = nums.size() - 1;

        while (low < high) {
            int mid = low + (high - low) / 2;

            // Ensure mid points to the start of a potential pair (even index)
            // or is the single element itself.
            // If mid is odd, decrement it to make it even.
            // This way, we always compare nums[mid] with nums[mid+1].
            if (mid % 2 == 1) {
                mid--;
            }

            // If nums[mid] == nums[mid+1], then the pair is correctly formed,
            // and the single element must be in the right half.
            if (nums[mid] == nums[mid + 1]) {
                low = mid + 2;
            } 
            // If nums[mid] != nums[mid+1], then nums[mid] is either the single element
            // or it's the second element of a pair (nums[mid-1], nums[mid]),
            // meaning the single element is in the left half or is nums[mid] itself.
            else {
                high = mid;
            }
        }

        return nums[low];
    }
};