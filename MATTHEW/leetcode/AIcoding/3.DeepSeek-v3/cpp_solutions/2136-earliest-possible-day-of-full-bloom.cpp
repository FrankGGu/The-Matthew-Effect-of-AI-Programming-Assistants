class Solution {
public:
    int earliestFullBloom(vector<int>& plantTime, vector<int>& growTime) {
        vector<pair<int, int>> plants;
        int n = plantTime.size();
        for (int i = 0; i < n; ++i) {
            plants.emplace_back(growTime[i], plantTime[i]);
        }
        sort(plants.begin(), plants.end(), greater<pair<int, int>>());
        int res = 0;
        int currentTime = 0;
        for (auto& [g, p] : plants) {
            currentTime += p;
            res = max(res, currentTime + g);
        }
        return res;
    }
};