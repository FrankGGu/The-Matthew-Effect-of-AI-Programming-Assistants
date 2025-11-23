#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countAlmostEqualPairs(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int a = nums[i];
                int b = nums[j];
                int diff = 0;
                while (a > 0 || b > 0) {
                    if ((a % 10) != (b % 10)) {
                        ++diff;
                    }
                    a /= 10;
                    b /= 10;
                }
                if (diff <= 2) {
                    ++count;
                }
            }
        }
        return count;
    }
};