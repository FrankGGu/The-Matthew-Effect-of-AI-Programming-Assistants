var checkWays = function(pairs) {
    const adj = new Map();
    const nodes = new Set();

    for (const [u, v] of pairs) {
        if (!adj.has(u)) adj.set(u, new Set());
        if (!adj.has(v)) adj.set(v, new Set());
        adj.get(u).add(v);
        adj.get(v).add(u);
        nodes.add(u);
        nodes.add(v);
    }

    let root = -1;
    for (const node of nodes) {
        if (adj.get(node).size === nodes.size - 1) {
            root = node;
            break;
        }
    }

    if (root === -1) return 0;

    let tree = new Map();
    tree.set(root, new Set());
    let count = 0;

    for (const node of nodes) {
        if (node === root) continue;
        let parent = -1, parentDegree = Infinity;
        for (const neighbor of adj.get(node)) {
            if (neighbor === root) {
                if (adj.get(node).size < nodes.size - 1) {
                    parent = root;
                    break;
                }
            } else {
                if (adj.get(neighbor).size < parentDegree && adj.get(neighbor).size >= adj.get(node).size) {
                     if (adj.get(node).has(neighbor)) {
                         parent = neighbor;
                         parentDegree = adj.get(neighbor).size;
                     }
                }
            }
        }

        if (parent === -1) return 0;

        tree.set(parent, (tree.get(parent) || new Set()).add(node));
        if (adj.get(parent).size === adj.get(node).size) count = 1;
    }

    function isValid(node, parent) {
        for (const child of tree.get(node) || []) {
            if (child === parent) continue;
            if (!adj.get(node).has(child)) return false;
            for (const neighbor of adj.get(child)) {
                if (neighbor !== node && !adj.get(node).has(neighbor)) {
                    return false;
                }
            }
            if (!isValid(child, node)) return false;
        }
        return true;
    }

    if (!isValid(root, -1)) return 0;
    return count === 1 ? 2 : 1;
};