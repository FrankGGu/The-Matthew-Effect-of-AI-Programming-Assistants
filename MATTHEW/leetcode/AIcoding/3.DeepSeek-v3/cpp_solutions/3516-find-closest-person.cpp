class Solution {
public:
    int findClosestPerson(vector<int>& seats) {
        int n = seats.size();
        vector<int> left(n, n), right(n, n);

        for (int i = 0; i < n; ++i) {
            if (seats[i] == 1) {
                left[i] = 0;
            } else if (i > 0) {
                left[i] = left[i - 1] + 1;
            }
        }

        for (int i = n - 1; i >= 0; --i) {
            if (seats[i] == 1) {
                right[i] = 0;
            } else if (i < n - 1) {
                right[i] = right[i + 1] + 1;
            }
        }

        int maxDist = 0;
        for (int i = 0; i < n; ++i) {
            if (seats[i] == 0) {
                int dist = min(left[i], right[i]);
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
        }

        return maxDist;
    }
};