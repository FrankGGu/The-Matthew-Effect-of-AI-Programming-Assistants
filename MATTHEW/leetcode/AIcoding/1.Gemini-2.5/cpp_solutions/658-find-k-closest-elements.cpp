#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    std::vector<int> findClosestElements(std::vector<int>& arr, int k, int x) {
        int left = 0;
        int right = arr.size() - 1;

        while (right - left + 1 > k) {
            if (std::abs(arr[left] - x) <= std::abs(arr[right] - x)) {
                right--;
            } else {
                left++;
            }
        }

        return std::vector<int>(arr.begin() + left, arr.begin() + right + 1);
    }
};