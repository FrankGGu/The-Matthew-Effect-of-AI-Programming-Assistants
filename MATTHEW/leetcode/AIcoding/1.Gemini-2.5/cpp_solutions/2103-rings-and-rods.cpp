#include <string>
#include <vector>

class Solution {
public:
    int countPoints(std::string rings) {
        std::vector<int> rod_colors(10, 0);

        for (int i = 0; i < rings.length(); i += 2) {
            char color_char = rings[i];
            int rod_idx = rings[i+1] - '0';

            if (color_char == 'R') {
                rod_colors[rod_idx] |= (1 << 0);
            } else if (color_char == 'G') {
                rod_colors[rod_idx] |= (1 << 1);
            } else if (color_char == 'B') {
                rod_colors[rod_idx] |= (1 << 2);
            }
        }

        int full_rods_count = 0;
        int target_mask = (1 << 0) | (1 << 1) | (1 << 2); // Represents all three colors (R, G, B)

        for (int i = 0; i < 10; ++i) {
            if (rod_colors[i] == target_mask) {
                full_rods_count++;
            }
        }

        return full_rods_count;
    }
};