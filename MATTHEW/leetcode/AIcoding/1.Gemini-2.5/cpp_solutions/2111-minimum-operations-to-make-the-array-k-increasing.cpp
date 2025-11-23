#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int kIncreasing(std::vector<int>& arr, int k) {
        int n = arr.size();
        int total_operations = 0;

        for (int i = 0; i < k; ++i) {
            std::vector<int> sub_arr;
            for (int j = i; j < n; j += k) {
                sub_arr.push_back(arr[j]);
            }
            total_operations += sub_arr.size() - longestNonDecreasingSubsequence(sub_arr);
        }
        return total_operations;
    }

private:
    int longestNonDecreasingSubsequence(const std::vector<int>& arr) {
        if (arr.empty()) {
            return 0;
        }
        std::vector<int> tails;
        for (int num : arr) {
            auto it = std::upper_bound(tails.begin(), tails.end(), num);
            if (it == tails.end()) {
                tails.push_back(num);
            } else {
                *it = num;
            }
        }
        return tails.size();
    }
};