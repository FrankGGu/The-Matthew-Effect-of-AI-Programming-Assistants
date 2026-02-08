#include <limits.h>
#include <stdbool.h>

typedef struct {
    int r, c;
} Point;

Point all_ones[900]; // Max 30*30 = 900 ones
int num_ones;
int GRID_ROWS, GRID_COLS;

int calculate_area_for_range(int target_min_r, int target_max_r, int target_min_c, int target_max_c) {
    int min_r = GRID_ROWS, max_r = -1, min_c = GRID_COLS, max_c = -1;
    bool found_one = false;

    for (int i = 0; i < num_ones; ++i) {
        Point p = all_ones[i];
        if (p.r >= target_min_r && p.r <= target_max_r &&
            p.c >= target_min_c && p.c <= target_max_c) {
            found_one = true;
            min_r = (min_r < p.r) ? min_r : p.r;
            max_r = (max_r > p.r) ? max_r : p.r;
            min_c = (min_c < p.c) ? min_c : p.c;
            max_c = (max_c > p.c) ? max_c : p.c;
        }
    }

    if (!found_one) {
        return 0;
    }
    return (max_r - min_r + 1) * (max_c - min_c + 1);
}

int min_two_rect_area_horizontal(int current_min_r, int current_max_r, int current_min_c, int current_max_c) {
    int min_two_area = INT_MAX;
    bool has_ones_in_range = false;
    for (int i = 0; i < num_ones; ++i) {
        Point p = all_ones[i];
        if (p.r >= current_min_r && p.r <= current_max_r &&
            p.c >= current_min_c && p.c <= current_max_c) {
            has_ones_in_range = true;
            break;
        }
    }
    if (!has_ones_in_range) {
        return 0;
    }

    // Iterate through all possible horizontal cut positions
    for (int r_cut = current_min_r; r_cut < current_max_r; ++r_cut) {
        int area1 = calculate_area_for_range(current_min_r, r_cut, current_min_c, current_max_c);
        int area2 = calculate_area_for_range(r_cut + 1, current_max_r, current_min_c, current_max_c);
        if (min_two_area > area1 + area2) {
            min_two_area = area1 + area2;
        }
    }
    return min_two_area;
}

int min_two_rect_area_vertical(int current_min_r, int current_max_r, int current_min_c, int current_max_c) {
    int min_two_area = INT_MAX;
    bool has_ones_in_range = false;
    for (int i = 0; i < num_ones; ++i) {
        Point p = all_ones[i];
        if (p.r >= current_min_r && p.r <= current_max_r &&
            p.c >= current_min_c && p.c <= current_max_c) {
            has_ones_in_range = true;
            break;
        }
    }
    if (!has_ones_in_range) {
        return 0;
    }

    // Iterate through all possible vertical cut positions
    for (int c_cut = current_min_c; c_cut < current_max_c; ++c_cut) {
        int area1 = calculate_area_for_range(current_min_r, current_max_r, current_min_c, c_cut);
        int area2 = calculate_area_for_range(current_min_r, current_max_r, c_cut + 1, current_max_c);
        if (min_two_area > area1 + area2) {
            min_two_area = area1 + area2;
        }
    }
    return min_two_area;
}

int minimumArea(int** grid, int gridSize, int* gridColSize) {
    GRID_ROWS = gridSize;
    GRID_COLS = gridColSize[0]; // Assuming rectangular grid

    num_ones = 0;
    int overall_min_r = GRID_ROWS, overall_max_r = -1;
    int overall_min_c = GRID_COLS, overall_max_c = -1;

    // Collect all '1's coordinates and determine the overall bounding box
    for (int r = 0; r < GRID_ROWS; ++r) {
        for (int c = 0; c < GRID_COLS; ++c) {
            if (grid[r][c] == 1) {
                all_ones[num_ones++] = (Point){r, c};
                overall_min_r = (overall_min_r < r) ? overall_min_r : r;
                overall_max_r = (overall_max_r > r) ? overall_max_r : r;
                overall_min_c = (overall_min_c < c) ? overall_min_c : c;
                overall_max_c = (overall_max_c > c) ? overall_max_c : c;
            }
        }
    }

    // If no '1's are found, the minimum area is 0
    if (num_ones == 0) {
        return 0;
    }

    int min_total_area = INT_MAX;

    // Case 1: One rectangle covering all '1's
    min_total_area = calculate_area_for_range(overall_min_r, overall_max_r, overall_min_c, overall_max_c);

    // Case 2: Two rectangles
    // Two horizontal strips
    for (int r_cut = overall_min_r; r_cut < overall_max_r; ++r_cut) {
        int area1 = calculate_area_for_range(overall_min_r, r_cut, overall_min_c, overall_max_c);
        int area2 = calculate_area_for_range(r_cut + 1, overall_max_r, overall_min_c, overall_max_c);
        if (min_total_area > area1 + area2) {
            min_total_area = area1 + area2;
        }
    }
    // Two vertical strips
    for (int c_cut = overall_min_c; c_cut < overall_max_c; ++c_cut) {
        int area1 = calculate_area_for_range(overall_min_r, overall_max_r, overall_min_c, c_cut);
        int area2 = calculate_area_for_range(overall_min_r, overall_max_r, c_cut + 1, overall_max_c);
        if (min_total_area > area1 + area2) {
            min_total_area = area1 + area2;
        }
    }

    // Case 3: Three rectangles
    // Three horizontal strips
    for (int r1_cut = overall_min_r; r1_cut < overall_max_r - 1; ++r1_cut) {
        for (int r2_cut = r1_cut + 1; r2_cut < overall_max_r; ++r2_cut) {
            int area1 = calculate_area_for_range(overall_min_r, r1_cut, overall_min_c, overall_max_c);
            int area2 = calculate_area_for_range(r1_cut + 1, r2_cut, overall_min_c, overall_max_c);
            int area3 = calculate_area_for_range(r2_cut + 1, overall_max_r, overall_min_c, overall_max_c);
            if (min_total_area > area1 + area2 + area3) {
                min_total_area = area1 + area2 + area3;
            }
        }
    }
    // Three vertical strips
    for (int c1_cut = overall_min_c; c1_cut < overall_max_c - 1; ++c1_cut) {
        for (int c2_cut = c1_cut + 1; c2_cut < overall_max_c; ++c2_cut) {
            int area1 = calculate_area_for_range(overall_min_r, overall_max_r, overall_min_c, c1_cut);
            int area2 = calculate_area_for_range(overall_min_r, overall_max_r, c1_cut + 1, c2_cut);
            int area3 = calculate_area_for_range(overall_min_r, overall_max_r, c2_cut + 1, overall_max_c);
            if (min_total_area > area1 + area2 + area3) {
                min_total_area = area1 + area2 + area3;
            }
        }
    }

    // One horizontal cut, then one part split vertically (2+1 configuration)
    // This means one rectangle covers the top part (or bottom), and two vertical rectangles cover the remaining part.
    for (int r_cut = overall_min_r; r_cut < overall_max_r; ++r_cut) {
        // Option A: Top part (rows <= r_cut) is one rectangle; bottom part (rows > r_cut) is split into two vertical rectangles.
        int area_top = calculate_area_for_range(overall_min_r, r_cut, overall_min_c, overall_max_c);
        int area_bottom_split = min_two_rect_area_vertical(r_cut + 1, overall_max_r, overall_min_c, overall_max_c);
        if (area_bottom_split != INT_MAX) { // Check if a valid split was possible for the bottom part
            if (min_total_area > area_top + area_bottom_split) {
                min_total_area = area_top + area_bottom_split;
            }
        }

        // Option B: Bottom part (rows > r_cut) is one rectangle; top part (rows <= r_cut) is split into two vertical rectangles.
        int area_bottom = calculate_area_for_range(r_cut + 1, overall_max_r, overall_min_c, overall_max_c);
        int area_top_split = min_two_rect_area_vertical(overall_min_r, r_cut, overall_min_c, overall_max_c);
        if (area_top_split != INT_MAX) { // Check if a valid split was possible for the top part
            if (min_total_area > area_bottom + area_top_split) {
                min_total_area = area_bottom + area_top_split;
            }
        }
    }

    // One vertical cut, then one part split horizontally (2+1 configuration)
    // This means one rectangle covers the left part (or right), and two horizontal rectangles cover the remaining part.
    for (int c_cut = overall_min_c; c_cut < overall_max_c; ++c_cut) {
        // Option A: Left part (cols <= c_cut) is one rectangle; right part (cols > c_cut) is split into two horizontal rectangles.
        int area_left = calculate_area_for_range(overall_min_r, overall_max_r, overall_min_c, c_cut);
        int area_right_split = min_two_rect_area_horizontal(overall_min_r, overall_max_r, c_cut + 1, overall_max_c);
        if (area_right_split != INT_MAX) { // Check if a valid split was possible for the right part
            if (min_total_area > area_left + area_right_split) {
                min_total_area = area_left + area_right_split;
            }
        }

        // Option B: Right part (cols > c_cut) is one rectangle; left part (cols <= c_cut) is split into two horizontal rectangles.
        int area_right = calculate_area_for_range(overall_min_r, overall_max_r, c_cut + 1, overall_max_c);
        int area_left_split = min_two_rect_area_horizontal(overall_min_r, overall_max_r, overall_min_c, c_cut);
        if (area_left_split != INT_MAX) { // Check if a valid split was possible for the left part
            if (min_total_area > area_right + area_left_split) {
                min_total_area = area_right + area_left_split;
            }
        }
    }

    return min_total_area;
}