class Deque {
    constructor() {
        this.data = {};
        this.head = 0;
        this.tail = 0;
    }

    push(element) {
        this.data[this.tail] = element;
        this.tail++;
    }

    pop() {
        if (this.head === this.tail) {
            return undefined;
        }
        this.tail--;
        const element = this.data[this.tail];
        delete this.data[this.tail];
        return element;
    }

    shift() {
        if (this.head === this.tail) {
            return undefined;
        }
        const element = this.data[this.head];
        delete this.data[this.head];
        this.head++;
        return element;
    }

    front() {
        if (this.head === this.tail) {
            return undefined;
        }
        return this.data[this.head];
    }

    back() {
        if (this.head === this.tail) {
            return undefined;
        }
        return this.data[this.tail - 1];
    }

    get length() {
        return this.tail - this.head;
    }
}

var minimumCost = function(nums, k, dist) {
    const n = nums.length;

    // prev_dp[i] stores the minimum cost to form 'c-1' subarrays,
    // with the (c-1)-th subarray starting at index 'i'.
    let prev_dp = new Array(n).fill(Infinity);

    // Base case: For 1 subarray, the cost is just nums[0], and it starts at index 0.
    prev_dp[0] = nums[0];

    // Iterate for 'c' from 2 to k (number of subarrays)
    for (let c = 2; c <= k; c++) {
        let current_dp = new Array(n).fill(Infinity);
        let dq = new Deque(); // Stores indices 'j' from prev_dp, maintaining monotonic property

        // Iterate 'i' from 'c-1' to 'n-1'. 'i' is the starting index of the 'c'-th subarray.
        // The first 'c-1' elements of nums must be used for 'c-1' subarrays, so 'i' must be at least 'c-1'.
        for (let i = c - 1; i < n; i++) {
            // Add prev_dp[i-1] to the deque if it's a valid cost.
            // i-1 is the potential starting index for the (c-1)-th subarray.
            // It must be >= c-2 (earliest possible start for c-1 subarrays).
            // Since 'i' starts at 'c-1', 'i-1' starts at 'c-2', so this condition is implicitly met.
            if (prev_dp[i-1] !== Infinity) {
                // Maintain monotonic increasing order of prev_dp values in the deque
                while (dq.length > 0 && prev_dp[dq.back()] >= prev_dp[i-1]) {
                    dq.pop();
                }
                dq.push(i-1);
            }

            // Remove elements from the front of the deque if their indices are out of the valid window.
            // The previous subarray must start at index 'p' such that i - dist <= p <= i - 1.
            while (dq.length > 0 && dq.front() < i - dist) {
                dq.shift();
            }

            // Calculate current_dp[i] if there's a valid previous subarray start in the window.
            if (dq.length > 0) {
                current_dp[i] = nums[i] + prev_dp[dq.front()];
            }
        }
        prev_dp = current_dp;
    }

    // The final answer is the minimum cost among all possible ending positions for the k-th subarray.
    // The k-th subarray must start at an index 'i' from k-1 to n-1.
    let min_total_cost = Infinity;
    for (let i = k - 1; i < n; i++) {
        min_total_cost = Math.min(min_total_cost, prev_dp[i]);
    }

    return min_total_cost;
};