var canReach = function(arr, start) {
    const n = arr.length;
    const queue = [start];
    const visited = new Array(n).fill(false);
    visited[start] = true;

    while (queue.length > 0) {
        const curr = queue.shift();

        if (arr[curr] === 0) {
            return true;
        }

        const jumpValue = arr[curr];

        const next1 = curr + jumpValue;
        if (next1 < n && !visited[next1]) {
            visited[next1] = true;
            queue.push(next1);
        }

        const next2 = curr - jumpValue;
        if (next2 >= 0 && !visited[next2]) {
            visited[next2] = true;
            queue.push(next2);
        }
    }

    return false;
};