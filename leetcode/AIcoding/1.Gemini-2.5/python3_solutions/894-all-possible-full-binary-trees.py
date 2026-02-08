from typing import List, Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def allPossibleFBT(self, n: int) -> List[Optional[TreeNode]]:
        memo = {}

        def generate_fbt(num_nodes):
            if num_nodes in memo:
                return memo[num_nodes]

            if num_nodes == 1:
                return [TreeNode(0)]

            if num_nodes % 2 == 0:
                return []

            result = []
            for i in range(1, num_nodes, 2):
                left_subtrees = generate_fbt(i)
                right_subtrees = generate_fbt(num_nodes - 1 - i)

                for left_tree in left_subtrees:
                    for right_tree in right_subtrees:
                        root = TreeNode(0)
                        root.left = left_tree
                        root.right = right_tree
                        result.append(root)

            memo[num_nodes] = result
            return result

        return generate_fbt(n)