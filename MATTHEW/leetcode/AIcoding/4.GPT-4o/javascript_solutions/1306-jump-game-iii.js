var canReach = function(arr, start) {
    const n = arr.length;
    const visited = new Set();
    const queue = [start];

    while (queue.length > 0) {
        const index = queue.shift();
        if (index < 0 || index >= n || visited.has(index)) continue;
        if (arr[index] === 0) return true;
        visited.add(index);
        queue.push(index + arr[index], index - arr[index]);
    }

    return false;
};