class Solution {
public:
    int earliestFullBloom(vector<int>& plantTime, vector<int>& growTime) {
        int n = plantTime.size();
        vector<pair<int, int>> plants(n);
        for (int i = 0; i < n; ++i) {
            plants[i] = {growTime[i], plantTime[i]};
        }
        sort(plants.rbegin(), plants.rend());

        int currentTime = 0, maxBloomDay = 0;
        for (const auto& [grow, plant] : plants) {
            currentTime += plant;
            maxBloomDay = max(maxBloomDay, currentTime + grow);
        }
        return maxBloomDay;
    }
};