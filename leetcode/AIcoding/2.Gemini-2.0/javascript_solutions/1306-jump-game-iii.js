var canReach = function(arr, start) {
    const n = arr.length;
    const visited = new Array(n).fill(false);
    const queue = [start];

    while (queue.length > 0) {
        const curr = queue.shift();

        if (arr[curr] === 0) {
            return true;
        }

        if (visited[curr]) {
            continue;
        }

        visited[curr] = true;

        const next1 = curr + arr[curr];
        const next2 = curr - arr[curr];

        if (next1 >= 0 && next1 < n) {
            queue.push(next1);
        }

        if (next2 >= 0 && next2 < n) {
            queue.push(next2);
        }
    }

    return false;
};