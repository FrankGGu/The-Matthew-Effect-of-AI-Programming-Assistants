from collections import deque

class Solution:
    def distanceK(self, root: TreeNode, target: TreeNode, k: int) -> list[int]:
        parent_map = {}

        def build_parent_map_dfs(node, parent):
            if not node:
                return
            parent_map[node] = parent
            build_parent_map_dfs(node.left, node)
            build_parent_map_dfs(node.right, node)

        build_parent_map_dfs(root, None)

        queue = deque([(target, 0)])
        visited = {target}
        result = []

        while queue:
            current_node, current_dist = queue.popleft()

            if current_dist == k:
                result.append(current_node.val)
                continue

            parent_node = parent_map.get(current_node)
            if parent_node and parent_node not in visited:
                queue.append((parent_node, current_dist + 1))
                visited.add(parent_node)

            if current_node.left and current_node.left not in visited:
                queue.append((current_node.left, current_dist + 1))
                visited.add(current_node.left)

            if current_node.right and current_node.right not in visited:
                queue.append((current_node.right, current_dist + 1))
                visited.add(current_node.right)

        return result