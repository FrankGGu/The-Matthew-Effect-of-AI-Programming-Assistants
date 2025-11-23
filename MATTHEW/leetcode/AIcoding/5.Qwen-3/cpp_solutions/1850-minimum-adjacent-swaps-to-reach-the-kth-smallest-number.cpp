#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getMinSwaps(string& target, int k) {
        vector<int> nums;
        for (char c : target) {
            nums.push_back(c - '0');
        }

        vector<int> original = nums;
        int n = nums.size();

        for (int i = 0; i < k - 1; ++i) {
            next_permutation(nums.begin(), nums.end());
        }

        int swaps = 0;
        for (int i = 0; i < n; ++i) {
            if (original[i] == nums[i]) continue;
            int j = i + 1;
            while (original[j] != nums[i]) ++j;
            for (int m = j; m > i; --m) {
                swap(original[m], original[m - 1]);
                ++swaps;
            }
        }

        return swaps;
    }
};