#include <vector>
#include <stack>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maximumScore(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> left(n, -1);
        vector<int> right(n, n);
        stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && nums[s.top()] < nums[i]) {
                right[s.top()] = i;
                s.pop();
            }
            s.push(i);
        }

        s = stack<int>();
        for (int i = n - 1; i >= 0; --i) {
            while (!s.empty() && nums[s.top()] <= nums[i]) {
                left[s.top()] = i;
                s.pop();
            }
            s.push(i);
        }

        vector<pair<int, int>> elements;
        for (int i = 0; i < n; ++i) {
            elements.emplace_back(nums[i], i);
        }
        sort(elements.rbegin(), elements.rend());

        long long result = 1;
        const int MOD = 1e9 + 7;
        for (auto& [num, i] : elements) {
            long long l = i - left[i] - 1;
            long long r = right[i] - i - 1;
            long long total = (l + 1) * (r + 1);
            long long take = min(total, (long long)k);
            result = (result * powMod(num, take, MOD)) % MOD;
            k -= take;
            if (k == 0) break;
        }

        return result;
    }

private:
    long long powMod(long long x, long long n, long long mod) {
        long long res = 1;
        x %= mod;
        while (n > 0) {
            if (n % 2 == 1) {
                res = (res * x) % mod;
            }
            x = (x * x) % mod;
            n /= 2;
        }
        return res;
    }
};