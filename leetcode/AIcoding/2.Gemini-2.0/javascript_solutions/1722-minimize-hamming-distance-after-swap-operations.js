var minimumHammingDistance = function(nums1, nums2, allowedSwaps) {
    const n = nums1.length;
    const parent = Array(n).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootX] = rootY;
        }
    }

    for (const [u, v] of allowedSwaps) {
        union(u, v);
    }

    const components = {};
    for (let i = 0; i < n; i++) {
        const root = find(i);
        if (!components[root]) {
            components[root] = { nums1: [], nums2: [] };
        }
        components[root].nums1.push(nums1[i]);
        components[root].nums2.push(nums2[i]);
    }

    let hammingDistance = 0;
    for (const root in components) {
        const { nums1, nums2 } = components[root];
        const freq1 = {};
        const freq2 = {};

        for (const num of nums1) {
            freq1[num] = (freq1[num] || 0) + 1;
        }

        for (const num of nums2) {
            freq2[num] = (freq2[num] || 0) + 1;
        }

        let count = 0;
        for (const num in freq1) {
            if (freq2[num]) {
                count += Math.min(freq1[num], freq2[num]);
            }
        }

        hammingDistance += nums1.length - count;
    }

    return hammingDistance;
};