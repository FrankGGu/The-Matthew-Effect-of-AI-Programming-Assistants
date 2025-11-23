class Solution {
public:
    int numOfBoomerangs(vector<vector<int>>& points) {
        int count = 0;
        for (const auto& p1 : points) {
            unordered_map<int, int> map;
            for (const auto& p2 : points) {
                if (p1 != p2) {
                    int dist = (p1[0] - p2[0]) * (p1[0] - p2[0]) + (p1[1] - p2[1]) * (p1[1] - p2[1]);
                    map[dist]++;
                }
            }
            for (const auto& m : map) {
                count += m.second * (m.second - 1);
            }
        }
        return count;
    }
};