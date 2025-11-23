var makeSubKSumEqual = function(arr, k) {
    let n = arr.length;
    k = k % n;
    let visited = new Array(n).fill(false);
    let ans = 0;

    for (let i = 0; i < n; i++) {
        if (visited[i]) continue;

        let cycle = [];
        let j = i;
        while (!visited[j]) {
            visited[j] = true;
            cycle.push(arr[j]);
            j = (j + k) % n;
        }

        cycle.sort((a, b) => a - b);
        let median = cycle[Math.floor(cycle.length / 2)];
        let moves = 0;
        for (let num of cycle) {
            moves += Math.abs(num - median);
        }
        ans += moves;
    }

    return ans;
};