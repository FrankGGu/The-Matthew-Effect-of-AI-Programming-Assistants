#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    std::vector<int> getStrongest(std::vector<int>& arr, int k) {
        std::sort(arr.begin(), arr.end());
        int n = arr.size();
        int median = arr[(n - 1) / 2];

        int left = 0;
        int right = n - 1;
        std::vector<int> result;
        result.reserve(k);

        while (result.size() < k) {
            if (std::abs(arr[left] - median) > std::abs(arr[right] - median)) {
                result.push_back(arr[left]);
                left++;
            } else {
                result.push_back(arr[right]);
                right--;
            }
        }

        return result;
    }
};