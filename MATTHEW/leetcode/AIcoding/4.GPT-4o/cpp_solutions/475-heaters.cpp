class Solution {
public:
    int findRadius(vector<int>& houses, vector<int>& heaters) {
        sort(heaters.begin(), heaters.end());
        int radius = 0;

        for (int house : houses) {
            int pos = lower_bound(heaters.begin(), heaters.end(), house) - heaters.begin();
            int dist1 = (pos == 0) ? INT_MAX : abs(house - heaters[pos - 1]);
            int dist2 = (pos == heaters.size()) ? INT_MAX : abs(house - heaters[pos]);
            radius = max(radius, min(dist1, dist2));
        }

        return radius;
    }
};