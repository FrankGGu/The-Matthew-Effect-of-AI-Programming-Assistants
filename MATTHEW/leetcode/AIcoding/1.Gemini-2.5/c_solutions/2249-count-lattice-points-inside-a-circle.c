#include <stdbool.h>
#include <string.h> // For memset

int countLatticePoints(int** circles, int circlesSize, int* circlesColSize) {
    // The maximum possible coordinate for a lattice point inside any circle is
    // max(xi + ri) = 100 + 100 = 200.
    // The minimum possible coordinate for a lattice point inside any circle is
    // min(xi - ri) = 1 - 100 = -99.
    // So, both x and y coordinates of relevant lattice points range from -99 to 200.
    // The size needed for a boolean array to cover this range is 200 - (-99) + 1 = 300.
    // We use an offset of 99 to map the coordinate range [-99, 200] to array indices [0, 299].

    static bool visited[300][300]; 

    // Re-initialize the visited array for each function call to ensure correctness
    // across multiple test cases in LeetCode's environment.
    memset(visited, 0, sizeof(visited));

    int count = 0;

    for (int i = 0; i < circlesSize; i++) {
        int xi = circles[i][0];
        int yi = circles[i][1];
        int ri = circles[i][2];

        // Iterate through all possible x coordinates within the bounding box of the current circle.
        // The x range is [xi - ri, xi + ri].
        for (int x = xi - ri; x <= xi + ri; x++) {
            // Iterate through all possible y coordinates within the bounding box of the current circle.
            // The y range is [yi - ri, yi + ri].
            for (int y = yi - ri; y <= yi + ri; y++) {
                // Check if the lattice point (x, y) is inside or on the current circle.
                // The distance formula is (x - xi)^2 + (y - yi)^2 <= ri^2.
                int dx = x - xi;
                int dy = y - yi;
                if (dx * dx + dy * dy <= ri * ri) {
                    // Map the lattice point coordinates (x, y) to array indices (ox, oy)
                    // by adding the offset 99.
                    int ox = x + 99;
                    int oy = y + 99;

                    // If this lattice point has not been visited yet, mark it as visited
                    // and increment the total count.
                    if (!visited[ox][oy]) {
                        visited[ox][oy] = true;
                        count++;
                    }
                }
            }
        }
    }

    return count;
}