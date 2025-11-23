#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> getStrongest(std::vector<int>& arr, int k) {
        std::sort(arr.begin(), arr.end());
        int n = arr.size();
        int m = arr[n / 2];
        std::sort(arr.begin(), arr.end(), [m](int a, int b) {
            return std::abs(a - m) > std::abs(b - m) || (std::abs(a - m) == std::abs(b - m) && a > b);
        });
        std::vector<int> result(arr.begin(), arr.begin() + k);
        return result;
    }
};