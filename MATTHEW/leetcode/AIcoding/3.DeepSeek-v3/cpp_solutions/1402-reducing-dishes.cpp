class Solution {
public:
    int maxSatisfaction(vector<int>& satisfaction) {
        sort(satisfaction.begin(), satisfaction.end());
        int n = satisfaction.size();
        int res = 0, total = 0;
        for (int i = n - 1; i >= 0 && satisfaction[i] + total > 0; --i) {
            total += satisfaction[i];
            res += total;
        }
        return res;
    }
};