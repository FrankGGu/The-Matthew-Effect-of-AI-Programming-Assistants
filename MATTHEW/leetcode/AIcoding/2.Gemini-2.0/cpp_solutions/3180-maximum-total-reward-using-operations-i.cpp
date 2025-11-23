#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumTotalReward(vector<int>& reward, int k) {
        int n = reward.size();
        sort(reward.begin(), reward.end(), greater<int>());
        int totalReward = 0;
        for (int i = 0; i < min(k, n); ++i) {
            totalReward += reward[i];
        }
        return totalReward;
    }
};