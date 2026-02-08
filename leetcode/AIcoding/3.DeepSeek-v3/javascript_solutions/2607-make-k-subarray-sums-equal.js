var makeSubKSumEqual = function(arr, k) {
    const n = arr.length;
    const visited = new Array(n).fill(false);
    let res = 0;

    for (let i = 0; i < n; i++) {
        if (visited[i]) continue;
        const group = [];
        let j = i;
        while (!visited[j]) {
            visited[j] = true;
            group.push(arr[j]);
            j = (j + k) % n;
        }
        group.sort((a, b) => a - b);
        const median = group[Math.floor(group.length / 2)];
        for (const num of group) {
            res += Math.abs(num - median);
        }
    }

    return res;
};