var accountsMerge = function(accounts) {
    const parent = new Map(); // email -> parent_email
    const nameMap = new Map(); // email -> name

    // Initialize parent map: each email is its own parent initially.
    // Also, store the name associated with each email.
    for (const account of accounts) {
        const name = account[0];
        for (let i = 1; i < account.length; i++) {
            const email = account[i];
            if (!parent.has(email)) {
                parent.set(email, email);
            }
            nameMap.set(email, name);
        }
    }

    // Find function with path compression
    const find = (email) => {
        if (parent.get(email) === email) {
            return email;
        }
        const root = find(parent.get(email));
        parent.set(email, root); // Path compression
        return root;
    };

    // Union function
    const union = (email1, email2) => {
        const root1 = find(email1);
        const root2 = find(email2);
        if (root1 !== root2) {
            parent.set(root1, root2); // Merge root1's tree under root2
        }
    };

    // Perform unions for all emails within the same account
    for (const account of accounts) {
        const firstEmail = account[1];
        for (let i = 2; i < account.length; i++) {
            const currentEmail = account[i];
            union(firstEmail, currentEmail);
        }
    }

    // Group emails by their ultimate root parent
    const mergedEmails = new Map(); // root_email -> Set<email>
    for (const email of parent.keys()) {
        const root = find(email);
        if (!mergedEmails.has(root)) {
            mergedEmails.set(root, new Set());
        }
        mergedEmails.get(root).add(email);
    }

    // Construct the final result
    const result = [];
    for (const rootEmail of mergedEmails.keys()) {
        const name = nameMap.get(rootEmail); // Get the name associated with this root group
        const emails = Array.from(mergedEmails.get(rootEmail));
        emails.sort(); // Sort emails alphabetically
        result.push([name, ...emails]);
    }

    return result;
};