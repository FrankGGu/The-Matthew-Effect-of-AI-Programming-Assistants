var diagonalSum = function(mat) {
    const n = mat.length;
    let sum = 0;

    for (let i = 0; i < n; i++) {
        // Add element from the primary diagonal
        sum += mat[i][i];
        // Add element from the secondary diagonal
        // Ensure it's not the same element as the primary diagonal for odd-sized matrices
        sum += mat[i][n - 1 - i];
    }

    // If n is odd, the center element (e.g., mat[1][1] for a 3x3 matrix)
    // was added twice (once for the primary diagonal and once for the secondary diagonal).
    // Subtract it once to get the correct sum.
    if (n % 2 === 1) {
        const centerIndex = Math.floor(n / 2);
        sum -= mat[centerIndex][centerIndex];
    }

    return sum;
};