var deleteDuplicateFolder = function(root) {
    const map = new Map();
    const duplicates = new Set();

    function dfs(node) {
        if (!node) return '';
        let key = '(' + node.name;
        const childrenKeys = [];
        for (const child of node.children) {
            childrenKeys.push(dfs(child));
        }
        childrenKeys.sort();
        key += childrenKeys.join('') + ')';

        if (map.has(key)) {
            duplicates.add(map.get(key));
            duplicates.add(node);
        } else {
            map.set(key, node);
        }

        return key;
    }

    dfs(root);

    function removeDuplicates(node) {
        if (!node) return;
        node.children = node.children.filter(child => !duplicates.has(child));
        for (const child of node.children) {
            removeDuplicates(child);
        }
    }

    removeDuplicates(root);
    return root;
};