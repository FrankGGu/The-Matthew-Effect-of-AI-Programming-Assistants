#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int tupleSameProduct(vector<int>& nums) {
        unordered_map<int, int> productCount;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                productCount[nums[i] * nums[j]]++;
            }
        }

        int ans = 0;
        for (auto const& [product, count] : productCount) {
            ans += count * (count - 1) * 4;
        }

        return ans;
    }
};