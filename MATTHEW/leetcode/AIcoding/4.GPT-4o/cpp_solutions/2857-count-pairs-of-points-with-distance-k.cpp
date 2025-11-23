class Solution {
public:
    int countPairs(vector<vector<int>>& points, int k) {
        int count = 0;
        for (int i = 0; i < points.size(); i++) {
            for (int j = i + 1; j < points.size(); j++) {
                int dist = (points[i][0] - points[j][0]) * (points[i][0] - points[j][0]) + 
                           (points[i][1] - points[j][1]) * (points[i][1] - points[j][1]);
                if (dist == k * k) {
                    count++;
                }
            }
        }
        return count;
    }
};