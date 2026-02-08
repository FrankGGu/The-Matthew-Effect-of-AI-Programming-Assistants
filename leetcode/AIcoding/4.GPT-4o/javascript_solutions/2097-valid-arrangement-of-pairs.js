class Solution {
    validArrangement(pairs) {
        const graph = new Map();
        const inDegree = new Map();
        const outDegree = new Map();

        for (const [u, v] of pairs) {
            graph.set(u, (graph.get(u) || []).concat(v));
            outDegree.set(u, (outDegree.get(u) || 0) + 1);
            inDegree.set(v, (inDegree.get(v) || 0) + 1);
        }

        const start = [...outDegree.keys()].find(x => (outDegree.get(x) || 0) - (inDegree.get(x) || 0) === 1) || pairs[0][0];

        const result = [];
        const dfs = (u) => {
            while (graph.get(u) && graph.get(u).length) {
                dfs(graph.get(u).pop());
            }
            result.push(u);
        };

        dfs(start);
        return result.reverse().slice(1).map((x, i) => [result[i], x]);
    }
}