class Solution:
    def createBinaryTree(self, descriptions: list[list[int]]) -> TreeNode:
        nodes = {}
        children = set()

        for parent_val, child_val, is_left in descriptions:
            if parent_val not in nodes:
                nodes[parent_val] = TreeNode(parent_val)
            if child_val not in nodes:
                nodes[child_val] = TreeNode(child_val)

            children.add(child_val)

            if is_left == 1:
                nodes[parent_val].left = nodes[child_val]
            else:
                nodes[parent_val].right = nodes[child_val]

        root = None
        for node_val in nodes:
            if node_val not in children:
                root = nodes[node_val]
                break

        return root