#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int numSquarefulArrays(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int result = 0;
        vector<int> path;
        vector<bool> used(n, false);

        function<void()> backtrack = [&]() {
            if (path.size() == n) {
                result++;
                return;
            }

            for (int i = 0; i < n; ++i) {
                if (used[i]) continue;
                if (i > 0 && nums[i] == nums[i - 1] && !used[i - 1]) continue;

                if (path.empty() || isPerfectSquare(static_cast<long long>(path.back() + nums[i]))) {
                    used[i] = true;
                    path.push_back(nums[i]);
                    backtrack();
                    path.pop_back();
                    used[i] = false;
                }
            }
        };

        backtrack();
        return result;
    }

private:
    bool isPerfectSquare(long long x) {
        if (x < 0) return false;
        long long s = sqrt(x);
        return s * s == x;
    }
};