#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minDominoRotations(std::vector<int>& tops, std::vector<int>& bottoms) {
        int n = tops.size();

        auto check = [&](int x) {
            int rotations_to_make_tops_x = 0;
            int rotations_to_make_bottoms_x = 0;

            for (int i = 0; i < n; ++i) {
                if (tops[i] != x && bottoms[i] != x) {
                    return std::numeric_limits<int>::max();
                }

                if (tops[i] != x) {
                    rotations_to_make_tops_x++;
                }

                if (bottoms[i] != x) {
                    rotations_to_make_bottoms_x++;
                }
            }
            return std::min(rotations_to_make_tops_x, rotations_to_make_bottoms_x);
        };

        int result1 = check(tops[0]);
        int result2 = check(bottoms[0]);

        if (result1 == std::numeric_limits<int>::max() && result2 == std::numeric_limits<int>::max()) {
            return -1;
        }
        return std::min(result1, result2);
    }
};