class Solution {
public:
    int maxDistToClosest(vector<int>& seats) {
        int n = seats.size();
        int prev = -1;
        int maxDist = 0;

        for (int i = 0; i < n; ++i) {
            if (seats[i] == 1) {
                if (prev == -1) {
                    maxDist = i;
                } else {
                    maxDist = max(maxDist, (i - prev) / 2);
                }
                prev = i;
            }
        }

        if (seats[n - 1] == 0) {
            maxDist = max(maxDist, n - 1 - prev);
        }

        return maxDist;
    }
};