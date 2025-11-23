function findScore(nums) {
    const n = nums.length;
    const visited = new Array(n).fill(false);
    const minHeap = [];

    for (let i = 0; i < n; i++) {
        minHeap.push([nums[i], i]);
    }

    minHeap.sort((a, b) => a[0] - b[0]);

    let score = 0;

    while (minHeap.length > 0) {
        const [val, i] = minHeap.shift();

        if (visited[i]) continue;

        score += val;

        if (i - 1 >= 0) visited[i - 1] = true;
        if (i + 1 < n) visited[i + 1] = true;
    }

    return score;
}