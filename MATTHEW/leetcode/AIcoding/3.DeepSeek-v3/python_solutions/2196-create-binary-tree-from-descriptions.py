class Solution:
    def createBinaryTree(self, descriptions: List[List[int]]) -> Optional[TreeNode]:
        nodes = {}
        children = set()
        parents = set()

        for parent, child, is_left in descriptions:
            parent_node = nodes.get(parent, TreeNode(parent))
            child_node = nodes.get(child, TreeNode(child))

            if is_left:
                parent_node.left = child_node
            else:
                parent_node.right = child_node

            nodes[parent] = parent_node
            nodes[child] = child_node
            children.add(child)
            parents.add(parent)

        root_val = (parents - children).pop()
        return nodes[root_val]