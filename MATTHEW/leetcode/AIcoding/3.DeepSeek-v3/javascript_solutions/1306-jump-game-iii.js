var canReach = function(arr, start) {
    const n = arr.length;
    const visited = new Array(n).fill(false);
    const queue = [start];
    visited[start] = true;

    while (queue.length > 0) {
        const current = queue.shift();
        if (arr[current] === 0) {
            return true;
        }
        const left = current - arr[current];
        if (left >= 0 && !visited[left]) {
            visited[left] = true;
            queue.push(left);
        }
        const right = current + arr[current];
        if (right < n && !visited[right]) {
            visited[right] = true;
            queue.push(right);
        }
    }
    return false;
};