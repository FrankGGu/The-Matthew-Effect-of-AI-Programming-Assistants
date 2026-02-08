#include <vector>
#include <algorithm>

class Solution {
public:
    int maxDistToClosest(std::vector<int>& seats) {
        int n = seats.size();
        int max_dist = 0;
        int last_person = -1;

        for (int i = 0; i < n; ++i) {
            if (seats[i] == 1) {
                if (last_person == -1) {
                    max_dist = i;
                } else {
                    max_dist = std::max(max_dist, (i - last_person) / 2);
                }
                last_person = i;
            }
        }

        max_dist = std::max(max_dist, n - 1 - last_person);

        return max_dist;
    }
};