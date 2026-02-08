#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int bestRotationScore(vector<int>& nums) {
        int n = nums.size();
        vector<int> score(n, 0);

        for (int i = 0; i < n; ++i) {
            int left = (i + 1) % n;
            int right = (i - nums[i] + n) % n;
            ++score[left];
            --score[right];
        }

        int maxScore = 0;
        int bestIndex = 0;
        int currentScore = 0;

        for (int i = 0; i < n; ++i) {
            currentScore += score[i];
            if (currentScore > maxScore) {
                maxScore = currentScore;
                bestIndex = i;
            }
        }

        return bestIndex;
    }
};