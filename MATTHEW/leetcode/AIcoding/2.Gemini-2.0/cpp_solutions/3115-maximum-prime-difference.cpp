#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumPrimeDifference(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int max_diff = -1;
        for (int i = 0; i < nums.size(); ++i) {
            if (isPrime(nums[i])) {
                for (int j = nums.size() - 1; j > i; --j) {
                    if (isPrime(nums[j])) {
                        max_diff = max(max_diff, nums[j] - nums[i]);
                        break;
                    }
                }
            }
        }
        return max_diff;
    }

private:
    bool isPrime(int n) {
        if (n <= 1) return false;
        for (int i = 2; i * i <= n; ++i) {
            if (n % i == 0) return false;
        }
        return true;
    }
};