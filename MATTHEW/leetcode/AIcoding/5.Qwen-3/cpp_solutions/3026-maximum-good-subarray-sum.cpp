#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumGood(vector<int>& skill, int k) {
        int n = skill.size();
        int maxSum = 0;
        int currentSum = 0;
        for (int i = 0; i < n; ++i) {
            if (i >= k) {
                currentSum -= skill[i - k];
            }
            currentSum += skill[i];
            if (i >= k - 1) {
                maxSum = max(maxSum, currentSum);
            }
        }
        return maxSum;
    }
};