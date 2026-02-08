var maximumManhattanDistance = function(points, k) {
    const n = points.length;

    if (n <= 1) {
        return 0;
    }

    // Transform (x, y) to (u, v) where u = x + y and v = x - y.
    // The Manhattan distance |x1 - x2| + |y1 - y2| is equivalent to max(|u1 - u2|, |v1 - v2|).
    // We want to maximize max(|u1 - u2|, |v1 - v2|), which means maximizing max(max(U) - min(U), max(V) - min(V)).

    const u_coords = new Array(n);
    const v_coords = new Array(n);

    for (let i = 0; i < n; i++) {
        u_coords[i] = points[i][0] + points[i][1];
        v_coords[i] = points[i][0] - points[i][1];
    }

    // Sort the u and v coordinates.
    u_coords.sort((a, b) => a - b);
    v_coords.sort((a, b) => a - b);

    // If we can change k points, we can effectively remove k points from consideration
    // for determining the min/max values of u and v.
    // To maximize the range (max - min) after removing k points, we consider all
    // contiguous subarrays of size (n - k) from the sorted array.

    // If n - k < 1, it means we are removing all points or more, so no distance can be formed.
    if (n - k < 1) {
        return 0;
    }

    let maxDistance = 0;

    // Iterate through all possible windows of size (n - k) in the sorted arrays.
    // 'i' represents the starting index of the window.
    // We can remove 'i' points from the beginning and 'k - i' points from the end.
    // The loop iterates from i = 0 to k.
    for (let i = 0; i <= k; i++) {
        // The rightmost index of the current window of (n - k) points.
        // If the window starts at 'i' and has length 'n - k', its end index is 'i + (n - k) - 1'.
        const right_idx = i + (n - k) - 1;

        // Calculate the range for u-coordinates for the current window.
        maxDistance = Math.max(maxDistance, u_coords[right_idx] - u_coords[i]);

        // Calculate the range for v-coordinates for the current window.
        maxDistance = Math.max(maxDistance, v_coords[right_idx] - v_coords[i]);
    }

    return maxDistance;
};