#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int sumCounts(vector<int>& nums) {
        int n = nums.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<int, int> freq;
            int distinct = 0;
            for (int j = i; j < n; ++j) {
                if (freq[nums[j]] == 0) {
                    distinct++;
                }
                freq[nums[j]]++;
                res += distinct * distinct;
            }
        }
        return res;
    }
};