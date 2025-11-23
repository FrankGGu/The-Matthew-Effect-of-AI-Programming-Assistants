var findMaximumLength = function(nums, k) {
    // Binary search to find the index of the first element >= target
    function lowerBound(arr, target) {
        let low = 0;
        let high = arr.length; // Exclusive upper bound
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    // Binary search to find the index of the last element <= target
    function upperBound(arr, target) {
        let low = 0;
        let high = arr.length; // Exclusive upper bound
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] <= target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low - 1;
    }

    class SegmentTree {
        constructor(size) {
            this.size = size;
            this.tree = new Array(4 * size).fill(0);
        }

        update(node, start, end, idx, val) {
            if (start === end) {
                this.tree[node] = Math.max(this.tree[node], val);
            } else {
                let mid = Math.floor((start + end) / 2);
                if (start <= idx && idx <= mid) {
                    this.update(2 * node, start, mid, idx, val);
                } else {
                    this.update(2 * node + 1, mid + 1, end, idx, val);
                }
                this.tree[node] = Math.max(this.tree[2 * node], this.tree[2 * node + 1]);
            }
        }

        query(node, start, end, l, r) {
            if (r < start || end < l) {
                return 0;
            }
            if (l <= start && end <= r) {
                return this.tree[node];
            }
            let mid = Math.floor((start + end) / 2);
            let p1 = this.query(2 * node, start, mid, l, r);
            let p2 = this.query(2 * node + 1, mid + 1, end, l, r);
            return Math.max(p1, p2);
        }
    }

    let all_values_set = new Set();
    for (let num of nums) {
        all_values_set.add(num);
        all_values_set.add(num - k);
        all_values_set.add(num + k);
    }

    let unique_coords = Array.from(all_values_set).sort((a, b) => a - b);

    let val_to_idx_map = new Map();
    for (let i = 0; i < unique_coords.length; i++) {
        val_to_idx_map.set(unique_coords[i], i);
    }

    const M = unique_coords.length;
    const st = new SegmentTree(M);
    let overall_max_len = 0;

    let distinct_nums_set = new Set(nums);
    let distinct_nums_sorted = Array.from(distinct_nums_set).sort((a, b) => a - b);

    for (let num of distinct_nums_sorted) {
        let max_prev_len = 0;

        // Query left range [num - k, num - 1]
        let query_low_left_idx = lowerBound(unique_coords, num - k);
        let query_high_left_idx = upperBound(unique_coords, num - 1);
        if (query_low_left_idx <= query_high_left_idx && query_high_left_idx >= 0 && query_low_left_idx < M) {
             max_prev_len = Math.max(max_prev_len, st.query(1, 0, M - 1, query_low_left_idx, query_high_left_idx));
        }

        // Query right range [num + 1, num + k]
        let query_low_right_idx = lowerBound(unique_coords, num + 1);
        let query_high_right_idx = upperBound(unique_coords, num + k);
        if (query_low_right_idx <= query_high_right_idx && query_high_right_idx >= 0 && query_low_right_idx < M) {
             max_prev_len = Math.max(max_prev_len, st.query(1, 0, M - 1, query_low_right_idx, query_high_right_idx));
        }

        let current_len = max_prev_len + 1;
        overall_max_len = Math.max(overall_max_len, current_len);

        let num_idx = val_to_idx_map.get(num);
        st.update(1, 0, M - 1, num_idx, current_len);
    }

    return overall_max_len;
};