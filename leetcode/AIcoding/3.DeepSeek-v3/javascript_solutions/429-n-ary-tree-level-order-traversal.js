var levelOrder = function(root) {
    if (!root) return [];
    let result = [];
    let queue = [root];
    while (queue.length > 0) {
        let levelSize = queue.length;
        let currentLevel = [];
        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            currentLevel.push(node.val);
            for (let child of node.children) {
                queue.push(child);
            }
        }
        result.push(currentLevel);
    }
    return result;
};