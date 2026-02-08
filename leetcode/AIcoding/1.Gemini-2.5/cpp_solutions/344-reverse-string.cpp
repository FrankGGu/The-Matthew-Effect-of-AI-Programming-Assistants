#include <vector>
#include <algorithm> // Required for std::swap, though manual swap is also fine

class Solution {
public:
    void reverseString(std::vector<char>& s) {
        int left = 0;
        int right = s.size() - 1;

        while (left < right) {
            std::swap(s[left], s[right]);
            left++;
            right--;
        }
    }
};