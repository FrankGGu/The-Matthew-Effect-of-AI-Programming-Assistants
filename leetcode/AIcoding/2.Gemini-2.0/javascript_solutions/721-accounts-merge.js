var accountsMerge = function(accounts) {
    const emailToName = new Map();
    const emailToId = new Map();
    let id = 0;
    const parent = [];

    const find = (i) => {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    };

    const union = (i, j) => {
        const rootI = find(i);
        const rootJ = find(j);
        if (rootI !== rootJ) {
            parent[rootI] = rootJ;
        }
    };

    for (const account of accounts) {
        const name = account[0];
        for (let i = 1; i < account.length; i++) {
            const email = account[i];
            emailToName.set(email, name);
            if (!emailToId.has(email)) {
                emailToId.set(email, id);
                parent[id] = id;
                id++;
            }

            if (i > 1) {
                union(emailToId.get(account[1]), emailToId.get(email));
            }
        }
    }

    const emailGroups = new Map();
    for (const email of emailToId.keys()) {
        const root = find(emailToId.get(email));
        if (!emailGroups.has(root)) {
            emailGroups.set(root, []);
        }
        emailGroups.get(root).push(email);
    }

    const result = [];
    for (const [root, emails] of emailGroups) {
        emails.sort();
        const name = emailToName.get(emails[0]);
        result.push([name, ...emails]);
    }

    return result;
};