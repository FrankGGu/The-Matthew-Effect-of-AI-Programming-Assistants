var canReach = function(s, minJump, maxJump) {
    const n = s.length;
    if (s[n - 1] === '1') {
        return false;
    }

    const queue = [0];
    const visited = new Array(n).fill(false);
    visited[0] = true;
    let reachable = 0;

    while (queue.length > 0) {
        const curr = queue.shift();

        for (let next = Math.max(curr + minJump, reachable + 1); next <= Math.min(curr + maxJump, n - 1); next++) {
            if (s[next] === '0' && !visited[next]) {
                queue.push(next);
                visited[next] = true;
            }
        }
        reachable = Math.min(curr + maxJump, n - 1);
    }

    return visited[n - 1];
};