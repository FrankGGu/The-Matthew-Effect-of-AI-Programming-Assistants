class Solution {
public:
    vector<int> goodDaysToRobBank(vector<int>& security, int time) {
        int n = security.size();
        vector<int> result;
        vector<int> nonIncreasing(n, 0);

        for (int i = 1; i < n; i++) {
            if (security[i] <= security[i - 1]) {
                nonIncreasing[i] = nonIncreasing[i - 1] + 1;
            }
        }

        for (int i = time; i <= n - time - 1; i++) {
            if (nonIncreasing[i] >= time && nonIncreasing[i + time] >= time) {
                result.push_back(i);
            }
        }

        return result;
    }
};