import collections

class Solution:
    def verticalTraversal(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root:
            return []

        col_map = collections.defaultdict(list)
        min_col = 0
        max_col = 0

        q = collections.deque([(root, 0, 0)])

        while q:
            node, col, row = q.popleft()

            col_map[col].append((row, node.val))
            min_col = min(min_col, col)
            max_col = max(max_col, col)

            if node.left:
                q.append((node.left, col - 1, row + 1))
            if node.right:
                q.append((node.right, col + 1, row + 1))

        result = []
        for col in range(min_col, max_col + 1):
            col_map[col].sort()

            current_col_nodes = [item[1] for item in col_map[col]]
            result.append(current_col_nodes)

        return result