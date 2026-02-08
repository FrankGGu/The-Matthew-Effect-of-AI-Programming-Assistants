class Solution {
public:
    int numberOfBoomerangs(vector<vector<int>>& points) {
        int count = 0;
        for (const auto& p1 : points) {
            unordered_map<int, int> distanceMap;
            for (const auto& p2 : points) {
                int dx = p1[0] - p2[0];
                int dy = p1[1] - p2[1];
                int distance = dx * dx + dy * dy;
                distanceMap[distance]++;
            }
            for (const auto& entry : distanceMap) {
                count += entry.second * (entry.second - 1);
            }
        }
        return count;
    }
};