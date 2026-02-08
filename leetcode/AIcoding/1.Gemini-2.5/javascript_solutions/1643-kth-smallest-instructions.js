var kthSmallestPath = function(destination, k) {
    let row = destination[0];
    let col = destination[1];

    let hRemaining = col; // Number of horizontal moves remaining
    let vRemaining = row; // Number of vertical moves remaining

    let result = [];

    // Helper function to calculate combinations (nCk)
    function combinations(n, k) {
        if (k < 0 || k > n) {
            return 0;
        }
        if (k === 0 || k === n) {
            return 1;
        }
        if (k > n / 2) {
            k = n - k;
        }
        let res = 1;
        for (let i = 1; i <= k; i++) {
            res = res * (n - i + 1) / i;
        }
        return res;
    }

    // Iterate for each character in the path
    for (let i = 0; i < row + col; i++) {
        if (hRemaining > 0) {
            // Calculate the number of paths that would start with 'H'
            // If we place 'H', we need to place (hRemaining - 1) more 'H's
            // in the remaining (hRemaining - 1 + vRemaining) positions.
            let pathsStartingWithH = combinations(hRemaining - 1 + vRemaining, hRemaining - 1);

            if (k <= pathsStartingWithH) {
                // The Kth path starts with 'H'
                result.push('H');
                hRemaining--;
            } else {
                // The Kth path starts with 'V'
                result.push('V');
                k -= pathsStartingWithH; // Subtract all paths starting with 'H'
                vRemaining--;
            }
        } else {
            // No more 'H' moves left, must place 'V'
            result.push('V');
            vRemaining--;
        }
    }

    return result.join('');
};