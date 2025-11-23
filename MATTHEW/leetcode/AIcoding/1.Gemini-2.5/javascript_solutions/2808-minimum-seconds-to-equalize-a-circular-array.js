var minimumSeconds = function(nums) {
    const n = nums.length;
    const num_indices = new Map();

    for (let i = 0; i < n; i++) {
        if (!num_indices.has(nums[i])) {
            num_indices.set(nums[i], []);
        }
        num_indices.get(nums[i]).push(i);
    }

    let min_seconds = Infinity;

    for (const [num, indices] of num_indices.entries()) {
        let max_dist_for_num = 0;

        if (indices.length === 1) {
            max_dist_for_num = n;
        } else {
            for (let i = 0; i < indices.length - 1; i++) {
                max_dist_for_num = Math.max(max_dist_for_num, indices[i+1] - indices[i]);
            }
            max_dist_for_num = Math.max(max_dist_for_num, n - indices[indices.length - 1] + indices[0]);
        }

        min_seconds = Math.min(min_seconds, Math.floor(max_dist_for_num / 2));
    }

    return min_seconds;
};