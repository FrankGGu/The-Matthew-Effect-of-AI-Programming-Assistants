#include <stdlib.h> // Required for abs if used, but max is sufficient for this problem.

int max(int a, int b) {
    return a > b ? a : b;
}

int largestOverlap(int** img1, int img1Size, int* img1ColSize, int** img2, int img2Size, int* img2ColSize) {
    int n = img1Size; // The dimensions of the square matrices
    int max_overlap = 0;

    // Iterate over all possible vertical shifts (dy) for img2 relative to img1.
    // dy ranges from -(n-1) to n-1.
    // For example, if n=3, dy ranges from -2 to 2.
    for (int dy = -(n - 1); dy < n; ++dy) {
        // Iterate over all possible horizontal shifts (dx) for img2 relative to img1.
        // dx ranges from -(n-1) to n-1.
        for (int dx = -(n - 1); dx < n; ++dx) {
            int current_overlap = 0;

            // Calculate the overlap for the current (dy, dx) translation.
            // We iterate through each cell (r1, c1) in img1.
            for (int r1 = 0; r1 < n; ++r1) {
                for (int c1 = 0; c1 < n; ++c1) {
                    // If img1 has a '1' at the current cell (r1, c1)
                    if (img1[r1][c1] == 1) {
                        // Determine the corresponding cell (r2, c2) in the original img2
                        // that would align with img1[r1][c1] after img2 is shifted by (dx, dy).
                        // If a cell (r2, c2) in original img2 moves to (r2+dy, c2+dx) in the shifted img2,
                        // and we want this shifted position to be (r1, c1),
                        // then r1 = r2 + dy  =>  r2 = r1 - dy
                        // and c1 = c2 + dx  =>  c2 = c1 - dx
                        int r2 = r1 - dy;
                        int c2 = c1 - dx;

                        // Check if this corresponding cell (r2, c2) is within the bounds of img2.
                        if (r2 >= 0 && r2 < n && c2 >= 0 && c2 < n) {
                            // If img2 also has a '1' at this position, it contributes to the overlap.
                            if (img2[r2][c2] == 1) {
                                current_overlap++;
                            }
                        }
                    }
                }
            }
            // Update the maximum overlap found so far.
            max_overlap = max(max_overlap, current_overlap);
        }
    }

    return max_overlap;
}