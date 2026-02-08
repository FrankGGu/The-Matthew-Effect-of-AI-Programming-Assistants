class TrieNode {
    constructor() {
        this.children = new Array(2).fill(null);
    }
}

class Trie {
    constructor() {
        this.root = new TrieNode();
        this.MAX_BITS = 30; // Max value 10^9 < 2^30
    }

    insert(num) {
        let node = this.root;
        for (let i = this.MAX_BITS; i >= 0; i--) {
            const bit = (num >> i) & 1;
            if (!node.children[bit]) {
                node.children[bit] = new TrieNode();
            }
            node = node.children[bit];
        }
    }

    queryMaxXor(num) {
        let node = this.root;
        let maxXor = 0;
        // If the Trie is empty (root has no children), return 0.
        // This can happen if the queried range has no elements.
        if (!node.children[0] && !node.children[1]) {
            return 0;
        }

        for (let i = this.MAX_BITS; i >= 0; i--) {
            const bit = (num >> i) & 1;
            const desiredBit = 1 - bit;

            if (node.children[desiredBit]) {
                maxXor |= (1 << i);
                node = node.children[desiredBit];
            } else if (node.children[bit]) {
                node = node.children[bit];
            } else {
                // This case should ideally not be reached if the Trie is non-empty
                // and we are guaranteed to find a number.
                return 0; 
            }
        }
        return maxXor;
    }
}

let segTree;
let prefixXORs;
let N_val;

function buildSegTree(nodeIdx, start, end) {
    segTree[nodeIdx] = new Trie();
    if (start === end) {
        return;
    }

    const mid = (start + end) >> 1;
    buildSegTree(2 * nodeIdx, start, mid);
    buildSegTree(2 * nodeIdx + 1, mid + 1, end);
}

function updateSegTree(nodeIdx, start, end, idxToUpdate, valToInsert) {
    segTree[nodeIdx].insert(valToInsert);
    if (start === end) {
        return;
    }

    const mid = (start + end) >> 1;
    if (idxToUpdate <= mid) {
        updateSegTree(2 * nodeIdx, start, mid, idxToUpdate, valToInsert);
    } else {
        updateSegTree(2 * nodeIdx + 1, mid + 1, end, idxToUpdate, valToInsert);
    }
}

function querySegTree(nodeIdx, start, end, queryL, queryR, target) {
    if (start > queryR || end < queryL) {
        return 0;
    }
    if (queryL <= start && end <= queryR) {
        return segTree[nodeIdx].queryMaxXor(target);
    }

    const mid = (start + end) >> 1;
    const leftMax = querySegTree(2 * nodeIdx, start, mid, queryL, queryR, target);
    const rightMax = querySegTree(2 * nodeIdx + 1, mid + 1, end, queryL, queryR, target);
    return Math.max(leftMax, rightMax);
}

function maxGeneticDifference(nums, queries) { // Renamed to match LeetCode function signature
    N_val = nums.length;

    prefixXORs = new Array(N_val + 1);
    prefixXORs[0] = 0;
    for (let i = 0; i < N_val; i++) {
        prefixXORs[i + 1] = prefixXORs[i] ^ nums[i];
    }

    // N_val + 1 elements in prefixXORs (from index 0 to N_val)
    // Segment tree needs to cover indices 0 to N_val
    segTree = new Array(4 * (N_val + 1));
    buildSegTree(1, 0, N_val);

    const queriesByR = new Array(N_val).fill(null).map(() => []);
    for (let q_idx = 0; q_idx < queries.length; q_idx++) {
        const [l, r, x] = queries[q_idx];
        queriesByR[r].push({ l, x, q_idx });
    }

    const results = new Array(queries.length);

    // Iterate 'j' from 0 to N_val-1. This 'j' represents the 'r' in a query [l, r, x].
    // It is also the rightmost index of the subarray nums[i...j].
    for (let current_r = 0; current_r < N_val; current_r++) {
        // Add P[current_r] to the segment tree at index current_r.
        // P[k] corresponds to nums[0]^...^nums[k-1].
        // So P[0] is for an empty prefix, P[1] for nums[0], etc.
        // We are interested in P[i] for 0 <= i <= current_r.
        updateSegTree(1, 0, N_val, current_r, prefixXORs[current_r]);

        // Process all queries whose 'r' value is current_r
        for (const query of queriesByR[current_r]) {
            const { l, x, q_idx } = query;

            // For a fixed 'j' (which is 'current_r'), we want to maximize:
            // (nums[i] ^ ... ^ nums[j]) ^ x
            // which is (prefixXORs[j+1] ^ prefixXORs[i]) ^ x
            // for l <= i <= j.
            // This simplifies to (prefixXORs[j+1] ^ x) ^ prefixXORs[i].
            // Let target_val = prefixXORs[j+1] ^ x.
            // We need to find max XOR of target_val with prefixXORs[i] for i in [l, j].
            const target_val = prefixXORs[current_r + 1] ^ x;

            // Query for prefixXORs[i] in the range [l, current_r]
            results[q_idx] = querySegTree(1, 0, N_val, l, current_r, target_val);
        }
    }

    return results;
}