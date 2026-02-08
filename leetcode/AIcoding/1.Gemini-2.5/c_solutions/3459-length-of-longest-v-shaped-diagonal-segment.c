#include <stdlib.h> // For qsort
#include <algorithm> // For std::max
#include <vector>    // For std::vector
#include <map>       // For std::map
#include <utility>   // For std::pair, std::make_pair

typedef struct {
    int x;
    int y;
} Point;

int comparePoints(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) {
        return p1->x - p2->x;
    }
    return p1->y - p2->y;
}

int longestVShapedDiagonalSegment(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 3) {
        return 0;
    }

    // Convert int** to a vector of Point structs for easier handling and sorting
    std::vector<Point> pts(pointsSize);
    for (int i = 0; i < pointsSize; ++i) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }

    // Sort points by x-coordinate, then y-coordinate
    qsort(pts.data(), pointsSize, sizeof(Point), comparePoints);

    int max_len = 0;

    // First pass: left to right
    // Stores the minimum x-coordinate encountered so far for points on a specific diagonal
    // map<diagonal_value, min_x_coordinate>
    std::map<int, int> min_x_left_d1; // d1_val = y - x (slope +1)
    std::map<int, int> min_x_left_d2; // d2_val = y + x (slope -1)

    // Stores (x_A, len_AB) for each point P_j as B
    // len_AB = P_j.x - x_A
    std::vector<std::pair<int, int>> best_left_d1(pointsSize); // For AB segment with slope +1
    std::vector<std::pair<int, int>> best_left_d2(pointsSize); // For AB segment with slope -1

    for (int j = 0; j < pointsSize; ++j) {
        Point p_j = pts[j];
        int d1_val = p_j.y - p_j.x;
        int d2_val = p_j.y + p_j.x;

        // Find best A for P_j (from points to its left)
        int x_A_d1_plus = -1; // x-coord of best A for AB with slope +1
        int x_A_d2_minus = -1; // x-coord of best A for AB with slope -1

        auto it_d1 = min_x_left_d1.find(d1_val);
        if (it_d1 != min_x_left_d1.end()) {
            x_A_d1_plus = it_d1->second;
        }

        auto it_d2 = min_x_left_d2.find(d2_val);
        if (it_d2 != min_x_left_d2.end()) {
            x_A_d2_minus = it_d2->second;
        }

        best_left_d1[j] = (x_A_d1_plus != -1) ? std::make_pair(x_A_d1_plus, p_j.x - x_A_d1_plus) : std::make_pair(-1, 0);
        best_left_d2[j] = (x_A_d2_minus != -1) ? std::make_pair(x_A_d2_minus, p_j.x - x_A_d2_minus) : std::make_pair(-1, 0);

        // Update min_x maps for points to be processed later (to the right of P_j)
        if (it_d1 == min_x_left_d1.end() || p_j.x < it_d1->second) {
            min_x_left_d1[d1_val] = p_j.x;
        }
        if (it_d2 == min_x_left_d2.end() || p_j.x < it_d2->second) {
            min_x_left_d2[d2_val] = p_j.x;
        }
    }

    // Second pass: right to left
    // Stores the maximum x-coordinate encountered so far for points on a specific diagonal
    // map<diagonal_value, max_x_coordinate>
    std::map<int, int> max_x_right_d1; // d1_val = y - x (slope +1)
    std::map<int, int> max_x_right_d2; // d2_val = y + x (slope -1)

    for (int j = pointsSize - 1; j >= 0; --j) {
        Point p_j = pts[j];
        int d1_val = p_j.y - p_j.x;
        int d2_val = p_j.y + p_j.x;

        // Find best C for P_j (from points to its right)
        int x_C_d1_plus = -1; // x-coord of best C for BC with slope +1
        int x_C_d2_minus = -1; // x-coord of best C for BC with slope -1

        auto it_d1 = max_x_right_d1.find(d1_val);
        if (it_d1 != max_x_right_d1.end()) {
            x_C_d1_plus = it_d1->second;
        }

        auto it_d2 = max_x_right_d2.find(d2_val);
        if (it_d2 != max_x_right_d2.end()) {
            x_C_d2_minus = it_d2->second;
        }

        // Combine left and right segments to form a V-shape
        // Case 1: AB segment has slope +1, BC segment has slope -1
        // (A is on d1 with P_j, C is on d2 with P_j)
        if (best_left_d1[j].first != -1 && x_C_d2_minus != -1) {
            max_len = std::max(max_len, best_left_d1[j].second + (x_C_d2_minus - p_j.x));
        }

        // Case 2: AB segment has slope -1, BC segment has slope +1
        // (A is on d2 with P_j, C is on d1 with P_j)
        if (best_left_d2[j].first != -1 && x_C_d1_plus != -1) {
            max_len = std::max(max_len, best_left_d2[j].second + (x_C_d1_plus - p_j.x));
        }

        // Update max_x maps for points to be processed later (to the left of P_j)
        if (it_d1 == max_x_right_d1.end() || p_j.x > it_d1->second) {
            max_x_right_d1[d1_val] = p_j.x;
        }
        if (it_d2 == max_x_right_d2.end() || p_j.x > it_d2->second) {
            max_x_right_d2[d2_val] = p_j.x;
        }
    }

    return max_len;
}