#include <vector>
using namespace std;

class Solution {
public:
    vector<int> twoSum(vector<int>& prices, int target) {
        int left = 0, right = prices.size() - 1;
        while (left < right) {
            int sum = prices[left] + prices[right];
            if (sum == target) {
                return {prices[left], prices[right]};
            } else if (sum > target) {
                --right;
            } else {
                ++left;
            }
        }
        return {};
    }
};