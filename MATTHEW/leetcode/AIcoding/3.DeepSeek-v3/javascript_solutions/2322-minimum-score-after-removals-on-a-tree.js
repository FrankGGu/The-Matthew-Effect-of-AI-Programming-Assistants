var minimumScore = function(nums, edges) {
    const n = nums.length;
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const xor = new Array(n).fill(0);
    const inTime = new Array(n).fill(0);
    const outTime = new Array(n).fill(0);
    let time = 0;

    function dfs(u, parent) {
        inTime[u] = time++;
        xor[u] = nums[u];
        for (const v of adj[u]) {
            if (v !== parent) {
                dfs(v, u);
                xor[u] ^= xor[v];
            }
        }
        outTime[u] = time - 1;
    }

    dfs(0, -1);

    let minScore = Infinity;

    for (let i = 1; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let a, b, c;
            if (inTime[i] < inTime[j] && outTime[i] >= outTime[j]) {
                a = xor[j];
                b = xor[i] ^ xor[j];
                c = xor[0] ^ xor[i];
            } else if (inTime[j] < inTime[i] && outTime[j] >= outTime[i]) {
                a = xor[i];
                b = xor[j] ^ xor[i];
                c = xor[0] ^ xor[j];
            } else {
                a = xor[i];
                b = xor[j];
                c = xor[0] ^ xor[i] ^ xor[j];
            }
            const max = Math.max(a, b, c);
            const min = Math.min(a, b, c);
            minScore = Math.min(minScore, max - min);
        }
    }

    return minScore;
};