class Solution {
public:
    int maxDistToClosest(vector<int>& seats) {
        int maxDist = 0, lastOccupied = -1, n = seats.size();

        for (int i = 0; i < n; ++i) {
            if (seats[i] == 1) {
                if (lastOccupied == -1) {
                    maxDist = i; // Leftmost seat
                } else {
                    maxDist = max(maxDist, (i - lastOccupied) / 2);
                }
                lastOccupied = i;
            }
        }

        maxDist = max(maxDist, n - 1 - lastOccupied); // Rightmost seat
        return maxDist;
    }
};