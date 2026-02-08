var kthSmallest = function(matrix, k) {
    const rows = matrix.length;
    const cols = matrix[0].length;

    let low = matrix[0][0];
    let high = matrix[rows - 1][cols - 1];
    let ans = matrix[rows - 1][cols - 1];

    // Helper function to count elements less than or equal to 'target'
    const countLessEqual = (mat, target) => {
        let count = 0;
        let r = 0;
        let c = cols - 1; // Start from top-right corner

        while (r < rows && c >= 0) {
            if (mat[r][c] <= target) {
                // All elements in the current row from 0 to c are <= target
                count += (c + 1);
                r++; // Move to the next row
            } else {
                // Current element is greater than target, move left in the current row
                c--;
            }
        }
        return count;
    };

    while (low <= high) {
        const mid = low + Math.floor((high - low) / 2);
        const count = countLessEqual(matrix, mid);

        if (count < k) {
            // There are fewer than k elements less than or equal to mid,
            // so the kth smallest must be greater than mid.
            low = mid + 1;
        } else {
            // There are k or more elements less than or equal to mid.
            // mid could be the answer, or we can find a smaller one.
            ans = mid;
            high = mid - 1;
        }
    }

    return ans;
};