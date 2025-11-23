var minTaps = function(n, ranges) {
    // max_reach[i] stores the maximum right endpoint reachable by a tap whose left endpoint is i.
    // Initialize with 0, meaning no tap starts at i by default.
    const max_reach = new Array(n + 1).fill(0);

    // Populate max_reach array
    // For each tap at position 'i' with range 'r', it covers the interval [i-r, i+r].
    // We want to find the maximum 'right' endpoint for each possible 'left' endpoint.
    for (let i = 0; i <= n; i++) {
        const r = ranges[i];
        if (r === 0) continue; 

        const left = Math.max(0, i - r);
        const right = Math.min(n, i + r);

        max_reach[left] = Math.max(max_reach[left], right);
    }

    let taps = 0;
    let current_covered_end = 0; // The rightmost point we have covered so far
    let next_possible_covered_end = 0; // The maximum point we can reach by opening one more tap

    // Iterate through the garden points from 0 to n
    for (let i = 0; i <= n; i++) {
        // Update the farthest point we can reach by considering taps that start at 'i' or before.
        // max_reach[i] gives us the best reach if a tap starts exactly at 'i'.
        next_possible_covered_end = Math.max(next_possible_covered_end, max_reach[i]);

        // If 'i' has moved beyond the current_covered_end, it means we need to open a new tap.
        // This also means 'i' is the first point not covered by previous taps.
        if (i === current_covered_end) {
            // If we cannot extend our coverage beyond 'i' (the point we just reached),
            // it means there's a gap or we are stuck.
            if (next_possible_covered_end <= i) {
                return -1;
            }
            // Open a new tap, and extend our coverage to the farthest possible point.
            current_covered_end = next_possible_covered_end;
            taps++;

            // If we have covered the entire garden, return the number of taps.
            if (current_covered_end >= n) {
                return taps;
            }
        }

        // Optimization: if we already covered 'n', we can stop early.
        // This check is important if 'current_covered_end' jumps far ahead.
        if (current_covered_end >= n) {
            return taps;
        }
    }

    // After the loop, if the entire garden is not covered (i.e., current_covered_end < n),
    // it means it's impossible.
    if (current_covered_end < n) {
        return -1;
    }

    return taps;
};