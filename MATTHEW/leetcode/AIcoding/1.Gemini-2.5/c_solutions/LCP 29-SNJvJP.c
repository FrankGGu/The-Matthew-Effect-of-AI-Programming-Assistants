long long min(long long a, long long b) {
    return a < b ? a : b;
}

int orchestraLayout(int n, int x, int y) {
    long long N = n;
    long long X = x;
    long long Y = y;

    // Calculate the layer k (0-indexed)
    // k is the minimum distance from any of the four borders (1-indexed coordinates)
    // Distance from top: X-1
    // Distance from bottom: N-X
    // Distance from left: Y-1
    // Distance from right: N-Y
    long long k = min(min(X - 1, N - X), min(Y - 1, N - Y));

    // Calculate the starting value for this layer k
    // This is the total number of elements in all outer layers (0 to k-1).
    // The sum for layers 0 to k-1 is 4 * k * (N - k)
    long long start_val = 4LL * k * (N - k);

    // Calculate the side length of the current square layer
    long long current_layer_side_length = N - 2 * k;

    long long ans;

    if (current_layer_side_length == 1) {
        // This is the center element for an odd N, or the only element in this layer.
        ans = start_val + 1;
    } else {
        // Coordinates relative to the current layer's top-left corner (1-indexed)
        // These range from 1 to current_layer_side_length
        long long row_in_layer = X - k;
        long long col_in_layer = Y - k;

        if (row_in_layer == 1) { // Top row: (k+1, y) where y is from k+1 to N-k
            // The value is start_val + (col_in_layer)
            // col_in_layer ranges from 1 to current_layer_side_length
            ans = start_val + col_in_layer;
        } else if (col_in_layer == current_layer_side_length) { // Right column: (x, N-k) where x is from k+2 to N-k
            // The value is start_val + (length of top row) + (offset in right column)
            // Offset in right column: (row_in_layer - 1) because row_in_layer starts from 2 for this segment
            ans = start_val + current_layer_side_length + (row_in_layer - 1);
        } else if (row_in_layer == current_layer_side_length) { // Bottom row: (N-k, y) where y is from N-k-1 down to k+1
            // The value is start_val + (length of top row) + (length of right column) + (offset in bottom row)
            // Offset in bottom row: (current_layer_side_length - col_in_layer)
            // col_in_layer ranges from 1 to current_layer_side_length - 1 for this segment
            ans = start_val + current_layer_side_length + (current_layer_side_length - 1) + (current_layer_side_length - col_in_layer);
        } else { // Left column: (x, k+1) where x is from N-k-1 down to k+2
            // The value is start_val + (length of top row) + (length of right column) + (length of bottom row) + (offset in left column)
            // Offset in left column: (current_layer_side_length - row_in_layer)
            // row_in_layer ranges from 2 to current_layer_side_length - 1 for this segment
            ans = start_val + current_layer_side_length + (current_layer_side_length - 1) + (current_layer_side_length - 1) + (current_layer_side_length - row_in_layer);
        }
    }

    // Apply modulo 9. The problem requires values 1, 2, ..., 9, 1, 2, ...
    // This is equivalent to (ans - 1) % 9 + 1.
    return (int)((ans - 1) % 9 + 1);
}