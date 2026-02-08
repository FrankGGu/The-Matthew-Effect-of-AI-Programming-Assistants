class Solution {
public:
    bool carPooling(vector<vector<int>>& trips, int capacity) {
        int diff[1001] = {0};
        for (auto& trip : trips) {
            int num = trip[0], from = trip[1], to = trip[2];
            diff[from] += num;
            if (to < 1001) {
                diff[to] -= num;
            }
        }
        int current = 0;
        for (int i = 0; i < 1001; ++i) {
            current += diff[i];
            if (current > capacity) {
                return false;
            }
        }
        return true;
    }
};