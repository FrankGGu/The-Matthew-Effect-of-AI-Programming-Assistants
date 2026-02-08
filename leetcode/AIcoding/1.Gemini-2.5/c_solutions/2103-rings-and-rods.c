#include <string.h>

int countPoints(char * rings){
    int rod_colors[10] = {0}; // Each element will store a bitmask for colors on that rod
                               // Bit 0: R, Bit 1: G, Bit 2: B
    int len = strlen(rings);

    for (int i = 0; i < len; i += 2) {
        char color_char = rings[i];
        int rod_idx = rings[i+1] - '0';

        int color_mask = 0;
        if (color_char == 'R') {
            color_mask = 1; // 001_2
        } else if (color_char == 'G') {
            color_mask = 2; // 010_2
        } else if (color_char == 'B') {
            color_mask = 4; // 100_2
        }

        rod_colors[rod_idx] |= color_mask;
    }

    int full_rods_count = 0;
    for (int i = 0; i < 10; i++) {
        // Check if all three bits are set (1 | 2 | 4 = 7)
        if (rod_colors[i] == 7) { 
            full_rods_count++;
        }
    }

    return full_rods_count;
}