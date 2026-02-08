var minimizeManhattanDistances = function(points) {
    const n = points.length;

    // If there are 2 or fewer points, removing one leaves 1 or 0 points.
    // The maximum Manhattan distance among 1 or 0 points is 0.
    if (n <= 2) {
        return 0;
    }

    // Transform coordinates to u = x + y and v = x - y.
    // Store them along with their original indices to keep track of which point they belong to.
    const u_values_indexed = new Array(n);
    const v_values_indexed = new Array(n);

    for (let i = 0; i < n; i++) {
        const [x, y] = points[i];
        u_values_indexed[i] = { value: x + y, index: i };
        v_values_indexed[i] = { value: x - y, index: i };
    }

    // Find the initial minimum and maximum u and v values, and the indices of the points
    // that correspond to these extreme values. These are the "extreme" points.
    let u_min_val = Infinity;
    let u_max_val = -Infinity;
    let u_min_idx = -1;
    let u_max_idx = -1;

    let v_min_val = Infinity;
    let v_max_val = -Infinity;
    let v_min_idx = -1;
    let v_max_idx = -1;

    for (let i = 0; i < n; i++) {
        if (u_values_indexed[i].value < u_min_val) {
            u_min_val = u_values_indexed[i].value;
            u_min_idx = i;
        }
        if (u_values_indexed[i].value > u_max_val) {
            u_max_val = u_values_indexed[i].value;
            u_max_idx = i;
        }
        if (v_values_indexed[i].value < v_min_val) {
            v_min_val = v_values_indexed[i].value;
            v_min_idx = i;
        }
        if (v_values_indexed[i].value > v_max_val) {
            v_max_val = v_values_indexed[i].value;
            v_max_idx = i;
        }
    }

    // Helper function to calculate the maximum Manhattan distance for the set of points
    // after removing the point at `removed_idx`.
    // This function iterates through all points (excluding the removed one) to find
    // the new min/max u and v values.
    const calculateMaxManhattan = (removed_idx) => {
        let current_u_min = Infinity;
        let current_u_max = -Infinity;
        let current_v_min = Infinity;
        let current_v_max = -Infinity;

        for (let i = 0; i < n; i++) {
            if (i === removed_idx) {
                continue; // Skip the removed point
            }
            current_u_min = Math.min(current_u_min, u_values_indexed[i].value);
            current_u_max = Math.max(current_u_max, u_values_indexed[i].value);
            current_v_min = Math.min(current_v_min, v_values_indexed[i].value);
            current_v_max = Math.max(current_v_max, v_values_indexed[i].value);
        }
        return Math.max(current_u_max - current_u_min, current_v_max - current_v_min);
    };

    // The key insight is that the optimal point to remove must be one of the points
    // that define the overall minimum or maximum u or v values in the original set.
    // Removing any other point would not change these extreme values, thus not reducing
    // the overall range.
    const candidate_removal_indices = new Set();
    candidate_removal_indices.add(u_min_idx);
    candidate_removal_indices.add(u_max_idx);
    candidate_removal_indices.add(v_min_idx);
    candidate_removal_indices.add(v_max_idx);

    let min_overall_max_manhattan = Infinity;

    // Iterate through the candidate points for removal and find the minimum possible
    // maximum Manhattan distance.
    for (const idx_to_remove of candidate_removal_indices) {
        min_overall_max_manhattan = Math.min(min_overall_max_manhattan, calculateMaxManhattan(idx_to_remove));
    }

    return min_overall_max_manhattan;
};