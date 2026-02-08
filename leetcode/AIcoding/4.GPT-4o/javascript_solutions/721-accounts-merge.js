var accountsMerge = function(accounts) {
    const emailToName = new Map();
    const graph = new Map();

    for (const account of accounts) {
        const name = account[0];
        for (let i = 1; i < account.length; i++) {
            const email = account[i];
            emailToName.set(email, name);
            if (!graph.has(email)) graph.set(email, new Set());
            if (i > 1) {
                graph.get(account[i - 1]).add(email);
                graph.get(email).add(account[i - 1]);
            }
        }
    }

    const visited = new Set();
    const result = [];

    const dfs = (email, component) => {
        visited.add(email);
        component.push(email);
        for (const neighbor of graph.get(email)) {
            if (!visited.has(neighbor)) {
                dfs(neighbor, component);
            }
        }
    };

    for (const email of graph.keys()) {
        if (!visited.has(email)) {
            const component = [];
            dfs(email, component);
            component.sort();
            result.push([emailToName.get(email), ...component]);
        }
    }

    return result;
};