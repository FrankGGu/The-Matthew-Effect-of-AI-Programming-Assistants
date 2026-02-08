#include <vector>
#include <algorithm> // For std::reverse if needed, but not strictly for this approach

class Solution {
public:
    std::vector<int> plusOne(std::vector<int>& digits) {
        int n = digits.size();
        for (int i = n - 1; i >= 0; --i) {
            if (digits[i] < 9) {
                digits[i]++;
                return digits;
            } else {
                digits[i] = 0;
            }
        }

        // If we reach here, it means all digits were 9 (e.g., [9,9,9])
        // We need to add a leading 1
        digits.insert(digits.begin(), 1);
        return digits;
    }
};