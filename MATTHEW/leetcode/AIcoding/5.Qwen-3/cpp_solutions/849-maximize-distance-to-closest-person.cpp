#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDistToClosest(vector<int>& seats) {
        int n = seats.size();
        int maxDist = 0;
        int prev = -1;

        for (int i = 0; i < n; ++i) {
            if (seats[i] == 1) {
                if (prev != -1) {
                    maxDist = max(maxDist, i - prev);
                } else {
                    maxDist = i;
                }
                prev = i;
            }
        }

        maxDist = max(maxDist, n - 1 - prev);

        return maxDist;
    }
};