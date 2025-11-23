from collections import deque

class Solution:
    def amountOfTime(self, root: Optional[TreeNode], start: int) -> int:
        parent = {}
        start_node = None

        def build_parent(node, par):
            nonlocal start_node
            if not node:
                return
            if node.val == start:
                start_node = node
            parent[node] = par
            build_parent(node.left, node)
            build_parent(node.right, node)

        build_parent(root, None)

        visited = set()
        queue = deque()
        queue.append(start_node)
        visited.add(start_node.val)
        time = -1

        while queue:
            time += 1
            for _ in range(len(queue)):
                current = queue.popleft()
                neighbors = []
                if current.left:
                    neighbors.append(current.left)
                if current.right:
                    neighbors.append(current.right)
                if parent[current]:
                    neighbors.append(parent[current])
                for neighbor in neighbors:
                    if neighbor.val not in visited:
                        visited.add(neighbor.val)
                        queue.append(neighbor)
        return time