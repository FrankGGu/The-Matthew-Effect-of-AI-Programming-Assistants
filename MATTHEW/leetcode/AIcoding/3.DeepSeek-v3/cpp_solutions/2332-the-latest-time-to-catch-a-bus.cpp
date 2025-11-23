class Solution {
public:
    int latestTimeCatchTheBus(vector<int>& buses, vector<int>& passengers, int capacity) {
        sort(buses.begin(), buses.end());
        sort(passengers.begin(), passengers.end());

        int n = buses.size();
        int m = passengers.size();
        int res = 0;
        int j = 0;

        for (int i = 0; i < n; ++i) {
            int cap = capacity;
            while (j < m && passengers[j] <= buses[i] && cap > 0) {
                if (j == 0 || passengers[j] - 1 != passengers[j - 1]) {
                    res = passengers[j] - 1;
                }
                ++j;
                --cap;
            }
            if (cap > 0 && (j == 0 || passengers[j - 1] != buses[i])) {
                res = buses[i];
            }
        }

        return res;
    }
};