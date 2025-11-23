#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    long long continuousSubarrays(vector<int>& nums) {
        map<int, int> freq;
        long long res = 0;
        int left = 0;

        for (int right = 0; right < nums.size(); ++right) {
            freq[nums[right]]++;

            while (freq.rbegin()->first - freq.begin()->first > 2) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    freq.erase(nums[left]);
                }
                left++;
            }

            res += right - left + 1;
        }

        return res;
    }
};