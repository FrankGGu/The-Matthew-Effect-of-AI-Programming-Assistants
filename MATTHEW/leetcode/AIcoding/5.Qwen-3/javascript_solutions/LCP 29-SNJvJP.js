function findValidPositions(n, m, k) {
    const result = [];
    const positions = new Set();

    function dfs(path, used) {
        if (path.length === k) {
            result.push([...path]);
            return;
        }

        for (let i = 1; i <= n; i++) {
            if (!used.has(i)) {
                let valid = true;
                for (let j = 0; j < path.length; j++) {
                    if (Math.abs(i - path[j]) < m) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    used.add(i);
                    path.push(i);
                    dfs(path, used);
                    path.pop();
                    used.delete(i);
                }
            }
        }
    }

    dfs([], new Set());
    return result;
}