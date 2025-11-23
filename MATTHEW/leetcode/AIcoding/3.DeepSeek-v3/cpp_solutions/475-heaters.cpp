class Solution {
public:
    int findRadius(vector<int>& houses, vector<int>& heaters) {
        sort(houses.begin(), houses.end());
        sort(heaters.begin(), heaters.end());
        int res = 0;
        int n = heaters.size();
        for (int house : houses) {
            int left = 0, right = n;
            while (left < right) {
                int mid = left + (right - left) / 2;
                if (heaters[mid] < house) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            int dist1 = (right == 0) ? INT_MAX : house - heaters[right - 1];
            int dist2 = (right == n) ? INT_MAX : heaters[right] - house;
            res = max(res, min(dist1, dist2));
        }
        return res;
    }
};