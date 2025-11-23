class Solution:
    def distanceK(self, root: TreeNode, target: TreeNode, k: int) -> List[int]:
        parent = {}
        def dfs(node, par=None):
            if node:
                parent[node] = par
                dfs(node.left, node)
                dfs(node.right, node)
        dfs(root)

        from collections import deque
        queue = deque([(target, 0)])
        visited = {target}
        res = []

        while queue:
            node, dist = queue.popleft()
            if dist == k:
                res.append(node.val)
            elif dist < k:
                for neighbor in (node.left, node.right, parent[node]):
                    if neighbor and neighbor not in visited:
                        visited.add(neighbor)
                        queue.append((neighbor, dist + 1))
        return res