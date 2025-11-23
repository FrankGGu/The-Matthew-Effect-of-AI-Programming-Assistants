#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int findPairs(vector<int>& nums, int k) {
        int count = 0;
        unordered_set<int> seen;
        sort(nums.begin(), nums.end());

        for (int i = 0; i < nums.size(); ++i) {
            if (seen.count(nums[i])) continue;
            for (int j = i + 1; j < nums.size(); ++j) {
                if (abs(nums[i] - nums[j]) == k) {
                    count++;
                    seen.insert(nums[i]);
                    break;
                } else if (abs(nums[i] - nums[j]) > k) {
                    break;
                }
            }
        }

        return count;
    }
};