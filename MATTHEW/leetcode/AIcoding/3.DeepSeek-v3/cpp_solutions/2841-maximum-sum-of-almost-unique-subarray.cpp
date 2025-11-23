#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxSum(vector<int>& nums, int m, int k) {
        unordered_map<int, int> freq;
        unordered_set<int> unique;
        long long current_sum = 0;
        long long max_sum = 0;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            int num = nums[right];
            freq[num]++;
            unique.insert(num);
            current_sum += num;

            while (right - left + 1 > k) {
                int left_num = nums[left];
                freq[left_num]--;
                if (freq[left_num] == 0) {
                    unique.erase(left_num);
                }
                current_sum -= left_num;
                left++;
            }

            if (right - left + 1 == k && unique.size() >= m) {
                max_sum = max(max_sum, current_sum);
            }
        }

        return max_sum;
    }
};