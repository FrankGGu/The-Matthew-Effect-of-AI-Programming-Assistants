function minReverseOperations(nums, k) {
    const n = nums.length;
    const res = new Array(n).fill(-1);
    const visited = new Array(n).fill(false);
    const queue = [];

    for (let i = 0; i < n; i++) {
        if (nums[i] === 0) {
            res[i] = 0;
            queue.push(i);
            visited[i] = true;
        }
    }

    while (queue.length > 0) {
        const pos = queue.shift();
        for (let i = Math.max(0, pos - k + 1); i <= Math.min(n - k, pos); i++) {
            const nextPos = i + k - 1;
            if (!visited[nextPos]) {
                res[nextPos] = res[pos] + 1;
                visited[nextPos] = true;
                queue.push(nextPos);
            }
        }
    }

    return res;
}