class Solution:
    def countPairs(self, root: TreeNode, distance: int) -> int:
        self.good_pairs = 0

        def dfs(node):
            if not node:
                return []

            if not node.left and not node.right:  # Leaf node
                return [1]

            left_distances = dfs(node.left)
            right_distances = dfs(node.right)

            for d_l in left_distances:
                for d_r in right_distances:
                    if d_l + d_r <= distance:
                        self.good_pairs += 1

            combined_distances = []
            for d in left_distances:
                if d + 1 <= distance:
                    combined_distances.append(d + 1)
            for d in right_distances:
                if d + 1 <= distance:
                    combined_distances.append(d + 1)

            return combined_distances

        dfs(root)
        return self.good_pairs