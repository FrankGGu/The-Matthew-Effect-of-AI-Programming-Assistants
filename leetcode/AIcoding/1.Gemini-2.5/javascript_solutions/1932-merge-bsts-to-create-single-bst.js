var canMerge = function(trees) {
    if (trees.length === 0) {
        return null;
    }

    const valToRootMap = new Map(); // Maps root.val to the root TreeNode
    const absorbedRoots = new Set(); // Stores values of roots that are found as leaf nodes in other trees
    let totalNodeCount = 0; // Total count of all nodes across all input trees

    // Step 1: Preprocessing - Populate maps/sets and count nodes
    for (const tree of trees) {
        if (valToRootMap.has(tree.val)) {
            // Duplicate root values in the input array. Invalid scenario.
            return null;
        }
        valToRootMap.set(tree.val, tree);

        const collectNodes = (node) => {
            if (!node) return;
            totalNodeCount++;

            if (node.left) collectNodes(node.left);
            if (node.right) collectNodes(node.right);

            // If it's a leaf node and its value is a root of another tree,
            // mark this value as an 'absorbed root'. This means this tree
            // must be merged into another tree at this leaf node.
            if (!node.left && !node.right && valToRootMap.has(node.val)) {
                absorbedRoots.add(node.val);
            }
        };
        collectNodes(tree);
    }

    // Step 2: Identify the final root of the merged BST
    let finalRootCandidate = null;
    for (const tree of trees) {
        // A tree is a candidate for the final root if its root value is NOT in `absorbedRoots`.
        // If it's in `absorbedRoots`, it means it must be merged into another tree.
        if (!absorbedRoots.has(tree.val)) {
            if (finalRootCandidate !== null) {
                // More than one candidate for the final root. Invalid scenario.
                return null;
            }
            finalRootCandidate = tree;
        }
    }

    if (finalRootCandidate === null) {
        // No single root found (e.g., all roots are absorbed, implying a cycle or no valid root).
        return null;
    }

    // Remove the final root from `valToRootMap` so it's not considered an unmerged tree
    // in the subsequent merge process.
    valToRootMap.delete(finalRootCandidate.val);

    // Step 3: Perform structural merges using DFS
    // This DFS function modifies the tree structure by replacing leaf nodes with new subtrees.
    // It does NOT perform full BST validation or node counting here.
    const performMergeDFS = (node) => {
        if (!node) {
            return null;
        }

        // If it's a leaf node, and its value matches a root in `valToRootMap`, attempt to merge.
        if (!node.left && !node.right && valToRootMap.has(node.val)) {
            const treeToMerge = valToRootMap.get(node.val);
            valToRootMap.delete(node.val); // Mark this root as used (removed from available roots)

            // Recursively merge children of the `treeToMerge` before returning it.
            // This ensures the entire subtree is processed.
            treeToMerge.left = performMergeDFS(treeToMerge.left);
            treeToMerge.right = performMergeDFS(treeToMerge.right);
            return treeToMerge; // Replace the current leaf node with the merged tree's root
        }

        // If not a merge point, just recurse on children to continue looking for merge opportunities.
        node.left = performMergeDFS(node.left);
        node.right = performMergeDFS(node.right);
        return node;
    };

    // Start the merging process from the identified final root candidate.
    const mergedRoot = performMergeDFS(finalRootCandidate);

    // Step 4: Final checks after all potential merges are performed
    // Check 1: All other roots should have been merged. If `valToRootMap` is not empty,
    // it means some trees were not absorbed.
    if (valToRootMap.size > 0) {
        return null;
    }

    // Check 2: Perform a final in-order traversal on the `mergedRoot` to validate the BST property
    // and count the total number of nodes in the final tree.
    let finalNodeCount = 0;
    let lastInOrderVal = -Infinity; // Used for BST property validation (strictly increasing values)
    let finalIsValid = true;

    const finalValidateDFS = (node) => {
        if (!node || !finalIsValid) {
            return;
        }

        finalValidateDFS(node.left);
        if (!finalIsValid) return; // Propagate invalid state

        // In-order check: current node's value must be strictly greater than the previous node's value
        if (node.val <= lastInOrderVal) {
            finalIsValid = false;
            return;
        }
        lastInOrderVal = node.val;
        finalNodeCount++;

        finalValidateDFS(node.right);
    };

    finalValidateDFS(mergedRoot);

    if (!finalIsValid) {
        return null;
    }

    // Check 3: The total number of nodes in the final merged tree should be
    // the initial `totalNodeCount` minus the number of `absorbedRoots`.
    // Each absorbed root replaces a leaf, effectively reducing the node count by 1 for each merge.
    if (finalNodeCount !== (totalNodeCount - absorbedRoots.size)) {
        return null;
    }

    return mergedRoot;
};