#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countCompleteSubarrays(vector<int>& nums) {
        unordered_set<int> distinctNums;
        for (int num : nums) {
            distinctNums.insert(num);
        }
        int k = distinctNums.size();
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            unordered_set<int> subarrayDistinctNums;
            for (int j = i; j < n; ++j) {
                subarrayDistinctNums.insert(nums[j]);
                if (subarrayDistinctNums.size() == k) {
                    count++;
                }
            }
        }
        return count;
    }
};