function deleteDuplicateFolders(paths) {
    const root = new Map();

    for (const path of paths) {
        let currentFolder = root;
        for (const folderName of path) {
            if (!currentFolder.has(folderName)) {
                currentFolder.set(folderName, new Map());
            }
            currentFolder = currentFolder.get(folderName);
        }
    }

    const serializedToNodesMap = new Map();
    const nodesToDelete = new Set();

    function serialize(node) {
        if (node.size === 0) {
            return "()";
        }

        const childSerializations = [];
        const sortedChildNames = Array.from(node.keys()).sort();

        for (const childName of sortedChildNames) {
            const childNode = node.get(childName);
            const childSubtreeSerialization = serialize(childNode);
            childSerializations.push(childName + childSubtreeSerialization);
        }

        const currentSerialization = "(" + childSerializations.join("") + ")";

        if (serializedToNodesMap.has(currentSerialization)) {
            nodesToDelete.add(node);
            for (const existingNode of serializedToNodesMap.get(currentSerialization)) {
                nodesToDelete.add(existingNode);
            }
        } else {
            serializedToNodesMap.set(currentSerialization, new Set());
        }
        serializedToNodesMap.get(currentSerialization).add(node);

        return currentSerialization;
    }

    serialize(root);

    const resultPaths = [];

    function collectPaths(node, currentPathArray) {
        if (nodesToDelete.has(node)) {
            return;
        }

        if (currentPathArray.length > 0) {
            resultPaths.push([...currentPathArray]);
        }

        const sortedChildNames = Array.from(node.keys()).sort();
        for (const childName of sortedChildNames) {
            const childNode = node.get(childName);
            currentPathArray.push(childName);
            collectPaths(childNode, currentPathArray);
            currentPathArray.pop();
        }
    }

    collectPaths(root, []);

    return resultPaths;
}