function countInfectionSequences(infection) {
    const n = infection.length;
    let count = 0;

    const dfs = (i, visited) => {
        if (i < 0 || i >= n || visited[i] || infection[i] === '0') return 0;
        visited[i] = true;
        let size = 1;
        size += dfs(i - 1, visited);
        size += dfs(i + 1, visited);
        return size;
    };

    for (let i = 0; i < n; i++) {
        if (infection[i] === '1') {
            const visited = new Array(n).fill(false);
            let size = dfs(i, visited);
            count += size * (size - 1) / 2;
        }
    }

    return count;
}