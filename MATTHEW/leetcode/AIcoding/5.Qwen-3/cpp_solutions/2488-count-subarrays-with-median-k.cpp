#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int medianIndex = -1;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == k) {
                medianIndex = i;
                break;
            }
        }

        unordered_map<int, int> countMap;
        countMap[0] = 1;

        int result = 0;
        int balance = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] < k) {
                balance--;
            } else if (nums[i] > k) {
                balance++;
            }

            if (i < medianIndex) {
                countMap[balance]++;
            } else {
                result += countMap[balance];
                result += countMap[balance - 1];
            }
        }

        return result;
    }
};