#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxFactorScore(vector<int>& nums) {
        unordered_map<int, long long> factorScore;
        long long maxScore = 0;

        for (int num : nums) {
            for (int i = 1; i * i <= num; ++i) {
                if (num % i == 0) {
                    factorScore[i] += num;
                    if (i != num / i) {
                        factorScore[num / i] += num;
                    }
                }
            }
        }

        for (const auto& [factor, score] : factorScore) {
            maxScore = max(maxScore, score);
        }

        return maxScore;
    }
};