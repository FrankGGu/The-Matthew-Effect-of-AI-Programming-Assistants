var friendRequests = function(n, restrictions, requests) {
    const parent = Array.from({ length: n }, (_, i) => i);

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
            parent[rootJ] = rootI;
            return true;
        }
        return false;
    };

    const result = [];

    for (const [u, v] of requests) {
        const rootU = find(u);
        const rootV = find(v);

        if (rootU === rootV) {
            result.push(true);
            continue;
        }

        let canGrant = true;
        for (const [x, y] of restrictions) {
            const rootX = find(x);
            const rootY = find(y);

            // Calculate hypothetical roots if rootU and rootV were merged.
            // Assuming rootV's group merges into rootU's group.
            const effectiveRootX = (rootX === rootV) ? rootU : rootX;
            const effectiveRootY = (rootY === rootV) ? rootU : rootY;

            // If after the hypothetical merge, x and y end up in the same group,
            // then this request cannot be granted.
            if (effectiveRootX === effectiveRootY) {
                canGrant = false;
                break;
            }
        }

        if (canGrant) {
            union(u, v);
            result.push(true);
        } else {
            result.push(false);
        }
    }

    return result;
};