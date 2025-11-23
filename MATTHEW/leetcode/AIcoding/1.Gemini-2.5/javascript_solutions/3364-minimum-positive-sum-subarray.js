var minPositiveSumSubarray = function(nums) {
    const n = nums.length;

    // Step 1: Collect all prefix sums
    // P[i] = sum(nums[0]...nums[i-1]), P[0] = 0
    const prefixSums = [0];
    let currentSum = 0;
    for (let i = 0; i < n; i++) {
        currentSum += nums[i];
        prefixSums.push(currentSum);
    }

    // Step 2: Coordinate compression
    // Create a sorted list of unique prefix sums to map them to ranks (0 to m-1)
    const uniqueSortedPrefixSums = [...new Set(prefixSums)].sort((a, b) => a - b);
    const rankMap = new Map();
    for (let i = 0; i < uniqueSortedPrefixSums.length; i++) {
        rankMap.set(uniqueSortedPrefixSums[i], i);
    }

    const m = uniqueSortedPrefixSums.length; // Number of unique prefix sums (compressed size)

    // Step 3: Segment Tree implementation
    // The segment tree will store the maximum prefix sum encountered so far within a rank range.
    // Initialize with a very small number (negative infinity) as prefix sums can be negative.
    const tree = new Array(4 * m).fill(Number.MIN_SAFE_INTEGER);

    // Segment tree update function (point update)
    // Sets the value at a specific rank (idx) in the segment tree.
    // node: current node index in the tree array
    // start, end: range of ranks covered by the current node
    // idx: rank to update
    // val: actual prefix sum value to store
    function update(node, start, end, idx, val) {
        if (start === end) { // Leaf node
            tree[node] = val; // Simply set the value at the leaf node
            return;
        }
        let mid = Math.floor((start + end) / 2);
        if (idx <= mid) {
            update(2 * node, start, mid, idx, val);
        } else {
            update(2 * node + 1, mid + 1, end, idx, val);
        }
        // Update parent node with the maximum of its children
        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
    }

    // Segment tree query function (range maximum query)
    // Queries for the maximum prefix sum within a given rank range [l, r].
    // node: current node index in the tree array
    // start, end: range of ranks covered by the current node
    // l, r: query range of ranks
    function query(node, start, end, l, r) {
        // If query range is invalid or outside current segment
        if (r < start || end < l || l > r) {
            return Number.MIN_SAFE_INTEGER;
        }
        // If query range fully covers current segment
        if (l <= start && end <= r) {
            return tree[node];
        }
        // Partial overlap, recurse
        let mid = Math.floor((start + end) / 2);
        let p1 = query(2 * node, start, mid, l, r);
        let p2 = query(2 * node + 1, mid + 1, end, l, r);
        return Math.max(p1, p2);
    }

    let minPositiveSum = Number.MAX_SAFE_INTEGER; // Initialize with a very large number

    // Process prefix sums
    currentSum = 0;
    // Add P[0] = 0 to the segment tree. This represents the empty prefix before any numbers.
    update(1, 0, m - 1, rankMap.get(0), 0);

    for (let i = 0; i < n; i++) {
        currentSum += nums[i]; // Calculate P[i+1]
        let currentRank = rankMap.get(currentSum);

        // Query for the largest prefix sum P_prev such that P_prev < currentSum
        // This corresponds to querying ranks from 0 to currentRank - 1 in the segment tree.
        // P_prev must have appeared at an index j <= i (i.e., before currentSum P[i+1]).
        let maxPrevSum = query(1, 0, m - 1, 0, currentRank - 1);

        // If a valid P_prev was found (not Number.MIN_SAFE_INTEGER)
        if (maxPrevSum !== Number.MIN_SAFE_INTEGER) {
            minPositiveSum = Math.min(minPositiveSum, currentSum - maxPrevSum);
        }

        // Add currentSum (P[i+1]) to the segment tree, marking it as "seen" for future queries.
        update(1, 0, m - 1, currentRank, currentSum);
    }

    // If minPositiveSum is still MAX_SAFE_INTEGER, it means no positive sum subarray was found.
    // Return -1 as per common LeetCode practice for "no solution" in such problems.
    return minPositiveSum === Number.MAX_SAFE_INTEGER ? -1 : minPositiveSum;
};