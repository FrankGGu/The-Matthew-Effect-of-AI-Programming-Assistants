var minJumps = function(arr) {
    const n = arr.length;
    if (n <= 1) {
        return 0;
    }

    const graph = new Map();
    for (let i = 0; i < n; i++) {
        if (!graph.has(arr[i])) {
            graph.set(arr[i], []);
        }
        graph.get(arr[i]).push(i);
    }

    const queue = [];
    queue.push([0, 0]); // [index, steps]

    const visited = new Array(n).fill(false);
    visited[0] = true;

    while (queue.length > 0) {
        const [currIdx, steps] = queue.shift();

        if (currIdx === n - 1) {
            return steps;
        }

        // Option 1: Jump to i + 1
        if (currIdx + 1 < n && !visited[currIdx + 1]) {
            visited[currIdx + 1] = true;
            queue.push([currIdx + 1, steps + 1]);
        }

        // Option 2: Jump to i - 1
        if (currIdx - 1 >= 0 && !visited[currIdx - 1]) {
            visited[currIdx - 1] = true;
            queue.push([currIdx - 1, steps + 1]);
        }

        // Option 3: Jump to any j where arr[i] == arr[j]
        if (graph.has(arr[currIdx])) {
            for (const nextIdx of graph.get(arr[currIdx])) {
                if (!visited[nextIdx]) {
                    visited[nextIdx] = true;
                    queue.push([nextIdx, steps + 1]);
                }
            }
            // Clear the list for this value to avoid re-processing and TLE
            graph.delete(arr[currIdx]);
        }
    }

    return -1; // Should not be reached if a path exists
};