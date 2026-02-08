#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long countBadPairs(vector<int>& nums) {
        int n = nums.size();
        long long totalPairs = (long long)n * (n - 1) / 2;
        unordered_map<int, int> count;
        long long goodPairs = 0;

        for (int i = 0; i < n; i++) {
            int diff = nums[i] - i;
            if (count.find(diff) != count.end()) {
                goodPairs += count[diff];
            }
            count[diff]++;
        }

        return totalPairs - goodPairs;
    }
};