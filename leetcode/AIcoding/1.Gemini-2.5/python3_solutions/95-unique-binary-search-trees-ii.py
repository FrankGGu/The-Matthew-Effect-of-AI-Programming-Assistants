from typing import List, Optional

class Solution:
    def generateTrees(self, n: int) -> List[Optional[TreeNode]]:
        if n == 0:
            return []

        def generate(start, end):
            if start > end:
                return [None]

            all_trees = []
            for i in range(start, end + 1):
                left_subtrees = generate(start, i - 1)
                right_subtrees = generate(i + 1, end)

                for l_tree in left_subtrees:
                    for r_tree in right_subtrees:
                        current_root = TreeNode(i)
                        current_root.left = l_tree
                        current_root.right = r_tree
                        all_trees.append(current_root)
            return all_trees

        return generate(1, n)