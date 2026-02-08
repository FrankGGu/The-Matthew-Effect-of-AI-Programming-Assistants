var accountsMerge = function(accounts) {
    const emailToName = new Map();
    const graph = new Map();

    for (const account of accounts) {
        const name = account[0];
        const firstEmail = account[1];
        for (let i = 1; i < account.length; i++) {
            const email = account[i];
            if (!graph.has(firstEmail)) graph.set(firstEmail, new Set());
            if (!graph.has(email)) graph.set(email, new Set());
            graph.get(firstEmail).add(email);
            graph.get(email).add(firstEmail);
            emailToName.set(email, name);
        }
    }

    const visited = new Set();
    const result = [];

    for (const email of graph.keys()) {
        if (!visited.has(email)) {
            visited.add(email);
            const stack = [email];
            const emails = [];
            while (stack.length > 0) {
                const current = stack.pop();
                emails.push(current);
                for (const neighbor of graph.get(current)) {
                    if (!visited.has(neighbor)) {
                        visited.add(neighbor);
                        stack.push(neighbor);
                    }
                }
            }
            emails.sort();
            result.push([emailToName.get(email), ...emails]);
        }
    }

    return result;
};