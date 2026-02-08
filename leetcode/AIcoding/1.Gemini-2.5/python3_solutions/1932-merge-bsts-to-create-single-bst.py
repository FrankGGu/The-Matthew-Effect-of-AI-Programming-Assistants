import collections

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def mergeBSTs(self, trees: list[TreeNode]) -> TreeNode:
        if not trees:
            return None

        # Helper to validate a single BST and check for unique values
        def _is_valid_bst_and_unique(node, low, high, seen_vals_set):
            if node is None:
                return True
            if not (low < node.val < high) or node.val in seen_vals_set:
                return False
            seen_vals_set.add(node.val)
            return _is_valid_bst_and_unique(node.left, low, node.val, seen_vals_set) and \
                   _is_valid_bst_and_unique(node.right, node.val, high, seen_vals_set)

        # Special case: only one tree
        if len(trees) == 1:
            seen_for_single_tree = set()
            if _is_valid_bst_and_unique(trees[0], 0, 100001, seen_for_single_tree):
                return trees[0]
            return None

        # Pre-processing for multiple trees
        root_map = {tree.val: tree for tree in trees}
        all_root_vals = set(root_map.keys())

        # total_unique_vals_original will store all unique values across all nodes in all initial trees.
        total_unique_vals_original = set()

        # leaf_vals_that_are_also_roots_candidates stores values that are leaves in some tree
        # AND are roots of some *other* tree. These are the trees that must be attached.
        leaf_vals_that_are_also_roots_candidates = set()

        for tree in trees:
            q = collections.deque([tree])
            while q:
                node = q.popleft()
                total_unique_vals_original.add(node.val)

                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)

                # If it's a leaf node
                if node.left is None and node.right is None:
                    # If this leaf's value is also a root of an original tree
                    if node.val in all_root_vals:
                        leaf_vals_that_are_also_roots_candidates.add(node.val)

        # Find the candidate for the final root of the merged BST.
        # It must be a root of one of the input trees, but not a leaf in any tree.
        candidate_roots = []
        for root_val in all_root_vals:
            if root_val not in leaf_vals_that_are_also_roots_candidates:
                candidate_roots.append(root_val)

        # If there isn't exactly one candidate for the final root, return None.
        if len(candidate_roots) != 1:
            return None

        final_root_val = candidate_roots[0]
        final_root = root_map[final_root_val]

        # Perform merging and validation using DFS
        merged_roots_count = 0  # Counts how many *other* trees were attached
        used_roots_for_attachment = set() # Tracks which tree roots have been attached
        seen_vals_in_final_tree = set() # Tracks all values in the final merged tree for uniqueness and completeness

        # The DFS function attempts to merge trees at leaf nodes and validates BST properties.
        # It returns the (potentially new) root of the subtree or None if invalid.
        def merge_and_validate_dfs(node, low, high):
            nonlocal merged_roots_count
            if node is None:
                return None

            # 1. Validate current node's value against BST bounds
            # Node values are between 1 and 10^5.
            if not (low < node.val < high):
                return None # Invalid BST property

            # 2. Check for duplicate values in the final merged tree
            if node.val in seen_vals_in_final_tree:
                return None # Duplicate value, invalid
            seen_vals_in_final_tree.add(node.val)

            # 3. If this node is a leaf, check if it matches a root of another tree to be attached
            if node.left is None and node.right is None:
                if node.val in root_map and node.val != final_root_val:
                    # This leaf's value matches the root of another original tree (T_other).
                    # This T_other needs to be attached here.

                    if node.val in used_roots_for_attachment:
                        return None # This tree root is being attached multiple times, invalid.

                    T_other = root_map[node.val]

                    # Mark T_other's root as used.
                    used_roots_for_attachment.add(T_other.val)
                    merged_roots_count += 1

                    # Recursively process T_other's children.
                    # The current node (which was a leaf) is conceptually replaced by T_other.
                    # So, T_other's children become the children of this position.
                    T_other.left = merge_and_validate_dfs(T_other.left, low, T_other.val)
                    if T_other.left is None and T_other.left is not None: return None # Failed to merge/validate left child

                    T_other.right = merge_and_validate_dfs(T_other.right, T_other.val, high)
                    if T_other.right is None and T_other.right is not None: return None # Failed to merge/validate right child

                    return T_other # Return the root of the attached tree (T_other)

            # 4. If not a leaf or no tree to attach, continue processing current node's children.
            node.left = merge_and_validate_dfs(node.left, low, node.val)
            if node.left is None and node.left is not None: return None # Failed to merge/validate left child

            node.right = merge_and_validate_dfs(node.right, node.val, high)
            if node.right is None and node.right is not None: return None # Failed to merge/validate right child

            return node

        # Start the merging and validation from the identified final root
        # Bounds are 0 and 100001 because node values are 1 to 10^5 inclusive.
        result_root = merge_and_validate_dfs(final_root, 0, 100001)

        # Final checks
        if result_root is None:
            return None

        # Ensure all (n-1) other trees were successfully merged
        if merged_roots_count != len(trees) - 1:
            return None

        # Ensure all unique values from the original trees are present in the final merged tree
        if len(seen_vals_in_final_tree) != len(total_unique_vals_original):
            return None

        return result_root