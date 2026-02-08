#include <vector>

using namespace std;

class Solution {
public:
    vector<int> maxScoreIndices(vector<int>& nums) {
        int n = nums.size();
        vector<int> ones(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            ones[i] = ones[i + 1] + nums[i];
        }

        int max_score = 0;
        vector<int> result;

        for (int i = 0; i <= n; ++i) {
            int score = 0;
            if (i > 0) {
                for (int j = 0; j < i; ++j) {
                    if (nums[j] == 0) {
                        score++;
                    }
                }
            }
            score += ones[i];

            if (score > max_score) {
                max_score = score;
                result.clear();
                result.push_back(i);
            } else if (score == max_score) {
                result.push_back(i);
            }
        }

        return result;
    }
};