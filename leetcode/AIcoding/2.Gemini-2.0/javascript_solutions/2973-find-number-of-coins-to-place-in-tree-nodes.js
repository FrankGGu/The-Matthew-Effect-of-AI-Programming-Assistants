var placedCoins = function(edges, cost) {
    const n = cost.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const ans = Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        let nums = [];

        const dfs = (node, parent, depth) => {
            if (depth > 2) return;
            if (node !== i) nums.push(cost[node]);

            for (const neighbor of adj[node]) {
                if (neighbor !== parent) {
                    dfs(neighbor, node, depth + 1);
                }
            }
        }

        dfs(i, -1, 0);
        nums.push(cost[i]);

        nums.sort((a, b) => a - b);

        let positive = [];
        let negative = [];

        for(let num of nums){
            if(num > 0){
                positive.push(num);
            } else if(num < 0){
                negative.push(num);
            }
        }

        let maxProduct = 1;

        if(positive.length >= 3){
            maxProduct = Math.max(maxProduct, positive[positive.length - 1] * positive[positive.length - 2] * positive[positive.length - 3]);
        }

        if(positive.length >= 1 && negative.length >= 2){
            maxProduct = Math.max(maxProduct, positive[positive.length - 1] * negative[0] * negative[1]);
        }

        if(maxProduct <= 0) ans[i] = 0;
        else ans[i] = maxProduct;
    }

    return ans;
};