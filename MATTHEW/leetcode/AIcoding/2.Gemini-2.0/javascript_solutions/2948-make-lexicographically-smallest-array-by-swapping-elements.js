var lexicographicallySmallestArray = function(nums, limit) {
    const n = nums.length;
    const indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => nums[a] - nums[b]);

    const visited = new Array(n).fill(false);

    for (let i = 0; i < n; i++) {
        if (visited[i]) continue;

        const group = [];
        let curr = i;

        while (curr < n) {
            if (!visited[curr] && Math.abs(nums[indices[i]] - nums[indices[curr]]) <= limit) {
                group.push(indices[curr]);
                visited[curr] = true;
            }
            curr++;
        }

        group.sort((a, b) => a - b);
        const values = group.map(idx => nums[idx]).sort((a, b) => a - b);

        for (let j = 0; j < group.length; j++) {
            nums[group[j]] = values[j];
        }
    }

    return nums;
};