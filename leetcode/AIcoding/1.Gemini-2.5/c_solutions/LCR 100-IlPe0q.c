int min(int a, int b) {
    return (a < b) ? a : b;
}

int minimumTotal(int** triangle, int triangleSize, int* triangleColSizes) {
    if (triangleSize == 0) {
        return 0;
    }

    // Start from the second to last row and move upwards
    // The last row already represents the minimum path sum to reach its elements
    for (int i = triangleSize - 2; i >= 0; i--) {
        // For each element in the current row 'i'
        // The number of elements in row 'i' is i + 1
        for (int j = 0; j <= i; j++) {
            // Update the current element with the sum of itself and the minimum
            // of its two children in the row below (i+1)
            triangle[i][j] += min(triangle[i+1][j], triangle[i+1][j+1]);
        }
    }

    // After the loops complete, triangle[0][0] will contain the minimum path sum
    // from the top to the bottom of the triangle.
    return triangle[0][0];
}