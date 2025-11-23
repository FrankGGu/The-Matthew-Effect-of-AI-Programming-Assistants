#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        unordered_set<int> num_set(nums.begin(), nums.end());
        int max_len = 0;

        for (int num : nums) {
            if (num_set.find(num - 1) == num_set.end()) {
                int current_num = num;
                int current_len = 1;

                while (num_set.find(current_num + 1) != num_set.end()) {
                    current_num++;
                    current_len++;
                }

                max_len = max(max_len, current_len);
            }
        }

        return max_len;
    }
};