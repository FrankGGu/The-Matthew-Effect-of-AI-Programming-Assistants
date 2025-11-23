class Solution {
public:
    int numDartsInArea(vector<vector<int>>& darts, vector<int>& radius) {
        int count = 0;
        double r = radius[0];
        for (const auto& dart : darts) {
            double dist = sqrt(dart[0] * dart[0] + dart[1] * dart[1]);
            if (dist <= r) {
                count++;
            }
        }
        return count;
    }
};