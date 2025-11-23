var deleteDuplicateFolder = function(paths) {
    const tree = new TreeNode(null);
    const pathMap = new Map();

    for (const path of paths) {
        let curr = tree;
        for (const dir of path) {
            if (!curr.hasOwnProperty(dir)) {
                curr[dir] = new TreeNode(null);
            }
            curr = curr[dir];
        }
    }

    const hashToNodes = new Map();

    function computeHash(node) {
        if (!node) {
            return "#";
        }

        const keys = Object.keys(node).sort();
        if (keys.length === 0) {
            return "()";
        }

        let hash = "(";
        for (const key of keys) {
            hash += key + computeHash(node[key]);
        }
        hash += ")";

        if (hash !== "()") {
            if (!hashToNodes.has(hash)) {
                hashToNodes.set(hash, []);
            }
            hashToNodes.get(hash).push(node);
        }

        return hash;
    }

    computeHash(tree);

    const toDelete = new Set();
    for (const [hash, nodes] of hashToNodes) {
        if (nodes.length > 1) {
            for (let i = 1; i < nodes.length; i++) {
                toDelete.add(nodes[i]);
            }
        }
    }

    const result = [];

    function collectPaths(node, path) {
        if (toDelete.has(node)) {
            return;
        }

        if (path.length > 0) {
            result.push([...path]);
        }

        for (const key of Object.keys(node).sort()) {
            const nextNode = node[key];
            collectPaths(nextNode, [...path, key]);
        }
    }

    collectPaths(tree, []);

    return result.sort();
};

function TreeNode(val, left, right) {
    this.val = (val===undefined ? 0 : val)
    this.left = (left===undefined ? null : left)
    this.right = (right===undefined ? null : right)
}