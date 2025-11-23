#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long countGoodPairs(vector<int>& nums) {
        unordered_map<int, int> count;
        long long ans = 0;
        for (int num : nums) {
            ans += count[num];
            count[num]++;
        }
        return ans;
    }
};