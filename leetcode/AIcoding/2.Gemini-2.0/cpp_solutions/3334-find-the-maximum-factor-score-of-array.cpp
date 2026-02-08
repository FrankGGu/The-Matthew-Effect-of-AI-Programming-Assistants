#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    long long maxFactorScore(vector<int>& nums) {
        long long maxScore = 0;
        for (int num : nums) {
            long long score = 0;
            for (int i = 1; i * i <= num; ++i) {
                if (num % i == 0) {
                    if (gcd(num, i) > 1) {
                        score += i;
                    }
                    if (i * i != num && gcd(num, num / i) > 1) {
                        score += num / i;
                    }
                }
            }
            maxScore = max(maxScore, score);
        }
        return maxScore;
    }

private:
    int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};