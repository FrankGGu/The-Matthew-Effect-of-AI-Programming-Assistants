#include <vector>

using namespace std;

class Solution {
public:
    long long countIncreasing(int n, vector<int>& nums) {
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (nums[j] > nums[i]) {
                    ans++;
                }
            }
        }
        return ans;
    }

    long long countDecreasing(int n, vector<int>& nums) {
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (nums[j] < nums[i]) {
                    ans++;
                }
            }
        }
        return ans;
    }

    long long countMonotonicPairs(int n, vector<int>& nums) {
        return countIncreasing(n, nums) + countDecreasing(n, nums);
    }
};