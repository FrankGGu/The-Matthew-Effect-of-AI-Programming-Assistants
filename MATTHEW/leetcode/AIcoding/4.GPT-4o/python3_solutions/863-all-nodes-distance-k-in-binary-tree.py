from collections import defaultdict, deque

class Solution:
    def distanceK(self, root: TreeNode, target: TreeNode, K: int) -> List[int]:
        graph = defaultdict(list)

        def build_graph(node, parent):
            if node:
                if parent:
                    graph[node].append(parent)
                    graph[parent].append(node)
                build_graph(node.left, node)
                build_graph(node.right, node)

        build_graph(root, None)

        ans = []
        queue = deque([target])
        visited = {target}
        level = 0

        while queue and level < K:
            for _ in range(len(queue)):
                node = queue.popleft()
                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            level += 1

        return [node.val for node in queue]