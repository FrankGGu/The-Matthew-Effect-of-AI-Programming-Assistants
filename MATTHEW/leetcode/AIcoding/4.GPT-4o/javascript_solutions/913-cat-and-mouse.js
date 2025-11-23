var catMouseGame = function(graph) {
    const n = graph.length;
    const memo = new Map();

    const dfs = (mouse, cat, turns) => {
        if (turns === 2 * n) return 0;
        if (mouse === 0) return 1;
        if (cat === mouse) return 2;

        const key = `${mouse},${cat},${turns % 2}`;
        if (memo.has(key)) return memo.get(key);

        let result = turns % 2 === 0 ? 2 : 0; // mouse's turn or cat's turn
        const neighbors = turns % 2 === 0 ? graph[mouse] : graph[cat];

        for (const neighbor of neighbors) {
            if (turns % 2 === 0) {
                const res = dfs(neighbor, cat, turns + 1);
                if (res === 1) return memo.set(key, 1) || 1;
                if (res === 0) result = 0;
            } else {
                if (neighbor !== 0) {
                    const res = dfs(mouse, neighbor, turns + 1);
                    if (res === 2) return memo.set(key, 2) || 2;
                    if (res === 0) result = 0;
                }
            }
        }
        return memo.set(key, result) || result;
    };

    return dfs(1, 2, 0);
};