var minMoves = function(nums, k) {
    const ones_indices = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            ones_indices.push(i);
        }
    }

    const m = ones_indices.length;
    if (m < k) {
        return 0; 
    }

    const adjusted_indices = new Array(m);
    for (let i = 0; i < m; i++) {
        adjusted_indices[i] = ones_indices[i] - i;
    }

    const prefix_sum_adj = new Array(m + 1).fill(0);
    for (let i = 0; i < m; i++) {
        prefix_sum_adj[i + 1] = prefix_sum_adj[i] + adjusted_indices[i];
    }

    let min_swaps = Infinity;

    for (let i = 0; i <= m - k; i++) {
        const median_idx_in_adj = i + Math.floor(k / 2);
        const median_val = adjusted_indices[median_idx_in_adj];

        const left_sum = prefix_sum_adj[median_idx_in_adj] - prefix_sum_adj[i];
        const right_sum = prefix_sum_adj[i + k] - prefix_sum_adj[median_idx_in_adj + 1];

        const num_left = Math.floor(k / 2);
        const num_right = k - 1 - num_left; 

        const current_swaps = (num_left * median_val - left_sum) + (right_sum - num_right * median_val);

        min_swaps = Math.min(min_swaps, current_swaps);
    }

    return min_swaps;
};