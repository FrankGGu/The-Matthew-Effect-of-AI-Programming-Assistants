var catMouseGame = function(graph) {
    const n = graph.length;
    const memo = new Map();

    const dp = (mouse, cat, turns) => {
        if (mouse === 0) return 1;
        if (cat === mouse) return 2;
        if (turns === 2 * n) return 0;

        const state = `${mouse},${cat},${turns}`;
        if (memo.has(state)) return memo.get(state);

        let result = turns % 2 === 0 ? 2 : 1;

        const neighbors = turns % 2 === 0 ? graph[mouse] : graph[cat];
        for (const neighbor of neighbors) {
            if (turns % 2 === 0 && neighbor === 0) continue;
            const nextMouse = turns % 2 === 0 ? neighbor : mouse;
            const nextCat = turns % 2 === 0 ? cat : neighbor;
            const nextResult = dp(nextMouse, nextCat, turns + 1);
            if (nextResult === 1) return memo.set(state, 1), 1;
            if (nextResult === 0) result = 0;
        }

        return memo.set(state, result), result;
    };

    return dp(1, 2, 0);
};