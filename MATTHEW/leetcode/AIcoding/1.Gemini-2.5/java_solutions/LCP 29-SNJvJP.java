class Solution {
    public long orchestraLayout(long n, long x, long y) {
        // Convert x, y to 0-indexed for easier calculation
        long x0 = x - 1;
        long y0 = y - 1;

        // k is the layer index (0-indexed).
        // It represents the minimum distance from the current cell to any border.
        long k = Math.min(Math.min(x0, n - 1 - x0), Math.min(y0, n - 1 - y0));

        // len is the side length of the square for the k-th layer.
        // For example, if n=5 and k=0, len=5. If k=1, len=3.
        long len = n - 2 * k;

        // start_val_k is the value at the top-left corner of the k-th layer (cell (k, k)).
        // This formula calculates the sum of elements in all outer layers (0 to k-1) plus 1.
        // The number of elements in layers 0 to k-1 is n*n - (n - 2*k)^2.
        // start_val_k = (n*n - (n - 2*k)*(n - 2*k)) + 1
        // This simplifies to: start_val_k = 4*k*(n-k) + 1
        long start_val_k = 4 * k * (n - k) + 1;

        long ans;

        // Determine which side of the k-th layer (x0, y0) is on and calculate the offset.
        if (x0 == k) {
            // Current cell is on the top row of the k-th layer: (k, k) to (k, n-1-k)
            // The offset from (k, k) is (y0 - k).
            ans = start_val_k + (y0 - k);
        } else if (y0 == n - 1 - k) {
            // Current cell is on the right column of the k-th layer: (k+1, n-1-k) to (n-1-k, n-1-k)
            // The value at (k, n-1-k) is start_val_k + (len - 1).
            // From there, we move down by (x0 - k) steps.
            ans = start_val_k + (len - 1) + (x0 - k);
        } else if (x0 == n - 1 - k) {
            // Current cell is on the bottom row of the k-th layer: (n-1-k, n-2-k) to (n-1-k, k)
            // The value at (n-1-k, n-1-k) is start_val_k + 2*(len - 1).
            // From there, we move left by ((n-1-k) - y0) steps.
            ans = start_val_k + 2 * (len - 1) + ((n - 1 - k) - y0);
        } else { // y0 == k
            // Current cell is on the left column of the k-th layer: (n-2-k, k) to (k+1, k)
            // The value at (n-1-k, k) is start_val_k + 3*(len - 1).
            // From there, we move up by ((n-1-k) - x0) steps.
            ans = start_val_k + 3 * (len - 1) + ((n - 1 - k) - x0);
        }

        // The problem requires returning the result modulo 9.
        return ans % 9;
    }
}