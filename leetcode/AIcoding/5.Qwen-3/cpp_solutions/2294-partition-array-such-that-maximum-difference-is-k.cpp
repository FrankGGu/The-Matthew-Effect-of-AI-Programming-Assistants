#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isPossibleDivide(vector<int>& nums, int k) {
        if (nums.size() % k != 0) return false;
        sort(nums.begin(), nums.end());
        vector<int> count(10001, 0);
        for (int num : nums) {
            count[num]++;
        }
        for (int i = 0; i <= 10000; ++i) {
            if (count[i] == 0) continue;
            if (count[i] > 0) {
                int current = count[i];
                for (int j = i + 1; j < i + k; ++j) {
                    if (count[j] < current) return false;
                    count[j] -= current;
                }
            }
        }
        return true;
    }
};