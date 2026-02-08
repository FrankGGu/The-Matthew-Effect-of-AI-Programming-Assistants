var findCircleNum = function(M) {
    const n = M.length;
    const visited = new Array(n).fill(false);

    const dfs = (i) => {
        for (let j = 0; j < n; j++) {
            if (M[i][j] === 1 && !visited[j]) {
                visited[j] = true;
                dfs(j);
            }
        }
    };

    let count = 0;
    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs(i);
            count++;
        }
    }

    return count;
};