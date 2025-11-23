class Solution {
public:
    bool canBeObtainedByRotation(vector<vector<int>>& target, vector<vector<int>>& arr) {
        if (target.size() != arr.size() || target[0].size() != arr[0].size()) return false;
        int n = target.size();
        vector<int> targetCount(101, 0), arrCount(101, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                targetCount[target[i][j]]++;
                arrCount[arr[i][j]]++;
            }
        }

        return targetCount == arrCount;
    }
};