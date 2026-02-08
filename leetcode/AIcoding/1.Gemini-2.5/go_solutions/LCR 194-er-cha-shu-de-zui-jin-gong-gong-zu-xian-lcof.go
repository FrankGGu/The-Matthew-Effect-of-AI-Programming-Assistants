func lowestCommonAncestor(root, p, q *TreeNode) *TreeNode {
    // Base case 1: If root is null, no common ancestor found in this path.
    if root == nil {
        return nil
    }

    // Base case 2: If root is p or q, then root is the LCA
    // (either root is the LCA, or one of them is an ancestor of the other,
    // and root is that ancestor).
    if root == p || root == q {
        return root
    }

    // Recursively search in the left subtree.
    leftLCA := lowestCommonAncestor(root.Left, p, q)
    // Recursively search in the right subtree.
    rightLCA := lowestCommonAncestor(root.Right, p, q)

    // Case 1: Both p and q are found in different subtrees (one in left, one in right).
    // In this case, the current root is the LCA.
    if leftLCA != nil && rightLCA != nil {
        return root
    }

    // Case 2: Both p and q (or just one of them, if the other is an ancestor)
    // are found in the left subtree.
    if leftLCA != nil {
        return leftLCA
    }

    // Case 3: Both p and q (or just one of them, if the other is an ancestor)
    // are found in the right subtree.
    if rightLCA != nil {
        return rightLCA
    }

    // Case 4: Neither p nor q were found in either subtree.
    return nil
}