class Solution {
    constructor() {
        this.graph = {};
    }

    calcEquation(equations, values, queries) {
        for (let i = 0; i < equations.length; i++) {
            const [u, v] = equations[i];
            if (!this.graph[u]) this.graph[u] = {};
            if (!this.graph[v]) this.graph[v] = {};
            this.graph[u][v] = values[i];
            this.graph[v][u] = 1 / values[i];
        }

        const results = [];
        for (const [u, v] of queries) {
            results.push(this.dfs(u, v, new Set()));
        }
        return results;
    }

    dfs(start, end, visited) {
        if (!this.graph[start] || !this.graph[end]) return -1;
        if (start === end) return 1;

        visited.add(start);

        for (const neighbor in this.graph[start]) {
            if (!visited.has(neighbor)) {
                const product = this.dfs(neighbor, end, visited);
                if (product !== -1) {
                    return product * this.graph[start][neighbor];
                }
            }
        }

        visited.delete(start);
        return -1;
    }
}