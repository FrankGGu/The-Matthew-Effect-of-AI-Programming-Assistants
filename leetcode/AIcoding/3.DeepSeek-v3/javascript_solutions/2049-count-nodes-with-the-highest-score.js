var countHighestScoreNodes = function(parents) {
    const n = parents.length;
    const children = new Array(n).fill(0).map(() => []);
    for (let i = 1; i < n; i++) {
        children[parents[i]].push(i);
    }

    let maxScore = 0;
    let count = 0;

    const dfs = (node) => {
        let left = 0, right = 0;
        if (children[node].length > 0) {
            left = dfs(children[node][0]);
        }
        if (children[node].length > 1) {
            right = dfs(children[node][1]);
        }
        const remaining = n - left - right - 1;
        const score = Math.max(left, 1) * Math.max(right, 1) * Math.max(remaining, 1);
        if (score > maxScore) {
            maxScore = score;
            count = 1;
        } else if (score === maxScore) {
            count++;
        }
        return left + right + 1;
    };

    dfs(0);
    return count;
};