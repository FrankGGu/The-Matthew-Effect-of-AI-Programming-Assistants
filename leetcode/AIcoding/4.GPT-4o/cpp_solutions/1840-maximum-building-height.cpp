class Solution {
public:
    int maxBuilding(vector<vector<int>>& towers, int maxHeight) {
        int n = towers.size();
        towers.push_back({0, 0});
        towers.push_back({1000000, 0});
        sort(towers.begin(), towers.end());
        n += 2;

        for (int i = 1; i < n; ++i) {
            int heightDiff = towers[i][1] - towers[i-1][1];
            int dist = towers[i][0] - towers[i-1][0];
            if (dist > heightDiff) {
                towers[i][1] = max(towers[i][1], towers[i-1][1] + dist);
            }
        }

        for (int i = n - 2; i >= 0; --i) {
            int heightDiff = towers[i+1][1] - towers[i][1];
            int dist = towers[i+1][0] - towers[i][0];
            if (dist > heightDiff) {
                towers[i][1] = max(towers[i][1], towers[i+1][1] + dist);
            }
        }

        int maxHeightResult = 0;
        for (int i = 0; i < n - 1; ++i) {
            int dist = towers[i+1][0] - towers[i][0];
            maxHeightResult = max(maxHeightResult, (towers[i][1] + towers[i+1][1] + dist) / 2);
        }

        return min(maxHeightResult, maxHeight);
    }
};