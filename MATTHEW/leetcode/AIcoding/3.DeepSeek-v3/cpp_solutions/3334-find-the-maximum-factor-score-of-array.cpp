#include <vector>
#include <unordered_map>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    int maxScore(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> factorCount;

        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    while (num % i == 0) {
                        factorCount[i]++;
                        num /= i;
                    }
                }
            }
            if (num > 1) {
                factorCount[num]++;
            }
        }

        vector<int> factors;
        for (auto& entry : factorCount) {
            factors.push_back(entry.first);
        }
        sort(factors.begin(), factors.end(), greater<int>());

        long long score = 0;
        for (int i = 0; i < factors.size(); ++i) {
            score += (long long)factors[i] * factorCount[factors[i]];
        }

        return score;
    }
};