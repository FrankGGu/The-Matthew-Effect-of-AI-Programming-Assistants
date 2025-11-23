#include <vector>
#include <algorithm>

class Solution {
public:
    int maxDistToClosest(std::vector<int>& seats) {
        int n = seats.size();
        int last_person_idx = -1;
        int max_dist = 0;

        for (int i = 0; i < n; ++i) {
            if (seats[i] == 1) {
                if (last_person_idx == -1) {
                    max_dist = std::max(max_dist, i);
                } else {
                    max_dist = std::max(max_dist, (i - last_person_idx) / 2);
                }
                last_person_idx = i;
            }
        }

        max_dist = std::max(max_dist, (n - 1 - last_person_idx));

        return max_dist;
    }
};