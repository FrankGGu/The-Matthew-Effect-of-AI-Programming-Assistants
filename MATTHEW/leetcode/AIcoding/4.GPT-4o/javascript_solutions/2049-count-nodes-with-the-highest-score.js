var countHighestScoreNodes = function(parents) {
    const n = parents.length;
    const children = Array.from({ length: n }, () => []);
    for (let i = 1; i < n; i++) {
        children[parents[i]].push(i);
    }

    const score = new Array(n).fill(1);
    let maxScore = 0;
    let maxCount = 0;

    const dfs = (node) => {
        let totalNodes = 0;
        for (const child of children[node]) {
            totalNodes += dfs(child);
        }
        if (totalNodes > 0) {
            score[node] *= totalNodes;
        }
        for (const child of children[node]) {
            if (totalNodes > 0) {
                score[node] *= (n - totalNodes - 1);
            }
        }
        return totalNodes + 1;
    };

    dfs(0);
    for (let i = 0; i < n; i++) {
        maxScore = Math.max(maxScore, score[i]);
    }
    for (let i = 0; i < n; i++) {
        if (score[i] === maxScore) {
            maxCount++;
        }
    }
    return maxCount;
};