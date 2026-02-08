var numberOfCoins = function(tree, cost) {
    const n = tree.length;
    const coins = new Array(n).fill(0);
    const visited = new Array(n).fill(false);
    const stack = [];

    for (let i = 0; i < n; i++) {
        if (tree[i] === -1) {
            stack.push(i);
            visited[i] = true;
        }
    }

    while (stack.length > 0) {
        const node = stack.pop();
        let parent = tree[node];

        if (parent !== -1) {
            coins[parent] += coins[node] + cost[node];
            if (!visited[parent]) {
                visited[parent] = true;
                stack.push(parent);
            }
        }
    }

    let total = 0;
    for (let i = 0; i < n; i++) {
        total += Math.abs(coins[i] + cost[i]);
    }

    return total;
};