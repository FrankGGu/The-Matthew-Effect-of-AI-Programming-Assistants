var minimumReverseOperations = function(n, p, banned, k) {
    const inf = Infinity;
    const dist = new Array(n).fill(inf);
    const queue = [];

    dist[p] = 0;
    queue.push(p);

    while (queue.length) {
        const cur = queue.shift();

        if (cur > 0 && !banned.has(cur - 1) && dist[cur - 1] > dist[cur] + 1) {
            dist[cur - 1] = dist[cur] + 1;
            queue.push(cur - 1);
        }

        if (cur < n - 1 && !banned.has(cur + 1) && dist[cur + 1] > dist[cur] + 1) {
            dist[cur + 1] = dist[cur] + 1;
            queue.push(cur + 1);
        }

        if (cur + k - 1 < n && cur - k + 1 >= 0) {
            let next = cur - k + 1;
            let prev = cur + k - 1;
            if (!banned.has(next) && dist[next] > dist[cur] + 1) {
                dist[next] = dist[cur] + 1;
                queue.push(next);
            }
            if (!banned.has(prev) && dist[prev] > dist[cur] + 1) {
                dist[prev] = dist[cur] + 1;
                queue.push(prev);
            }
        }
    }

    let result = Math.min(...dist.filter(d => d < inf));
    return result === inf ? -1 : result;
};