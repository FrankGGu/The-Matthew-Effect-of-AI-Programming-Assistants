#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> replaceNonCoprime(vector<int>& nums) {
        vector<long long> res;
        for (int num : nums) {
            long long n = num;
            while (!res.empty() && gcd(res.back(), n) > 1) {
                n = lcm(res.back(), n);
                res.pop_back();
            }
            res.push_back(n);
        }
        vector<int> ans(res.begin(), res.end());
        return ans;
    }

private:
    long long gcd(long long a, long long b) {
        if (b == 0) return a;
        return gcd(b, a % b);
    }

    long long lcm(long long a, long long b) {
        return (a * b) / gcd(a, b);
    }
};