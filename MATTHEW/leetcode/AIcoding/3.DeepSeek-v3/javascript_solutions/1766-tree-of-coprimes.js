var getCoprimes = function(nums, edges) {
    const n = nums.length;
    const tree = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        tree[u].push(v);
        tree[v].push(u);
    }

    const result = new Array(n).fill(-1);
    const path = [];
    const gcdMemo = new Map();
    const coprimes = Array.from({ length: 51 }, () => []);

    for (let i = 1; i <= 50; i++) {
        for (let j = 1; j <= 50; j++) {
            if (gcd(i, j) === 1) {
                coprimes[i].push(j);
            }
        }
    }

    const stack = [];
    stack.push([0, -1, new Map()]);

    while (stack.length > 0) {
        const [node, parent, ancestors] = stack.pop();
        const num = nums[node];
        let maxDepth = -1;
        let ancestorNode = -1;

        for (const coprime of coprimes[num]) {
            if (ancestors.has(coprime)) {
                const { depth, node: ancNode } = ancestors.get(coprime);
                if (depth > maxDepth) {
                    maxDepth = depth;
                    ancestorNode = ancNode;
                }
            }
        }

        result[node] = ancestorNode;

        const newAncestors = new Map(ancestors);
        if (newAncestors.has(num)) {
            const existing = newAncestors.get(num);
            if (existing.depth < path.length) {
                newAncestors.set(num, { depth: path.length, node });
            }
        } else {
            newAncestors.set(num, { depth: path.length, node });
        }

        path.push(node);

        for (const child of tree[node]) {
            if (child !== parent) {
                stack.push([child, node, newAncestors]);
            }
        }
    }

    return result;
};

function gcd(a, b) {
    while (b !== 0) {
        const temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}