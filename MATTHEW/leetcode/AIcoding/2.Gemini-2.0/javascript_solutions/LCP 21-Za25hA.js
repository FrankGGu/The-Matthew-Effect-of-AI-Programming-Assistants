var chasingGame = function(n, edges, startAlice, startBob, target) {
    const graph = Array(n + 1).fill(null).map(() => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    if (startAlice === target) {
        return 0;
    }

    const bobDist = Array(n + 1).fill(Infinity);
    const queue = [startBob];
    bobDist[startBob] = 0;

    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of graph[u]) {
            if (bobDist[v] === Infinity) {
                bobDist[v] = bobDist[u] + 1;
                queue.push(v);
            }
        }
    }

    if (bobDist[target] === Infinity) {
        return -1;
    }

    let maxDist = -1;
    const aliceDist = Array(n + 1).fill(Infinity);
    const aliceQueue = [startAlice];
    aliceDist[startAlice] = 0;

    while (aliceQueue.length > 0) {
        const u = aliceQueue.shift();
        if (aliceDist[u] > bobDist[u]) continue;

        for (const v of graph[u]) {
            if (aliceDist[v] === Infinity) {
                aliceDist[v] = aliceDist[u] + 1;
                aliceQueue.push(v);
            }
        }
    }

    for (let i = 1; i <= n; i++) {
        if (aliceDist[i] <= bobDist[i] && aliceDist[i] !== Infinity) {
            maxDist = Math.max(maxDist, aliceDist[i]);
        }
    }

    if (maxDist === -1) return -1;

    const targetDist = Array(n + 1).fill(Infinity);
    const targetQueue = [target];
    targetDist[target] = 0;

    while (targetQueue.length > 0) {
        const u = targetQueue.shift();
        for (const v of graph[u]) {
            if (targetDist[v] === Infinity) {
                targetDist[v] = targetDist[u] + 1;
                targetQueue.push(v);
            }
        }
    }

    let ans = Infinity;
    for (let i = 1; i <= n; i++) {
        if (aliceDist[i] <= bobDist[i] && aliceDist[i] !== Infinity) {
            ans = Math.min(ans, aliceDist[i] + targetDist[i]);
        }
    }

    return ans === Infinity ? -1 : ans;
};