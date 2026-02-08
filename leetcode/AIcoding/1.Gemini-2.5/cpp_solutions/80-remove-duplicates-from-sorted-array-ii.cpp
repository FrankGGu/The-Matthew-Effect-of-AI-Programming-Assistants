#include <vector>

class Solution {
public:
    int removeDuplicates(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }

        int k = 0; // Pointer for the next position in the modified array

        for (int i = 0; i < nums.size(); ++i) {
            // If k < 2, it means we can always add the first two elements.
            // Or if the current element is different from the element at k-2,
            // it means we haven't placed two occurrences of this number yet,
            // or it's a new number entirely.
            if (k < 2 || nums[i] != nums[k - 2]) {
                nums[k] = nums[i];
                k++;
            }
        }

        return k;
    }
};