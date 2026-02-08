class Solution:
    def canMerge(self, trees: List[TreeNode]) -> TreeNode:
        from collections import defaultdict

        leaves = set()
        tree_dict = {}
        val_to_node = defaultdict(list)

        for tree in trees:
            tree_dict[tree.val] = tree
            if tree.left:
                leaves.add(tree.left.val)
            if tree.right:
                leaves.add(tree.right.val)

        candidates = [tree_val for tree_val in tree_dict if tree_val not in leaves]
        if len(candidates) != 1:
            return None

        root_val = candidates[0]
        root = tree_dict[root_val]
        del tree_dict[root_val]

        current_nodes = [root]

        while current_nodes and tree_dict:
            node = current_nodes.pop(0)

            if node.left:
                left_val = node.left.val
                if left_val in tree_dict:
                    node.left = tree_dict[left_val]
                    del tree_dict[left_val]
                    current_nodes.append(node.left)

            if node.right:
                right_val = node.right.val
                if right_val in tree_dict:
                    node.right = tree_dict[right_val]
                    del tree_dict[right_val]
                    current_nodes.append(node.right)

        if tree_dict:
            return None

        stack = []
        prev = None
        current = root

        while stack or current:
            while current:
                stack.append(current)
                current = current.left
            current = stack.pop()
            if prev and prev.val >= current.val:
                return None
            prev = current
            current = current.right

        return root