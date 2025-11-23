from collections import deque

def canReach(n, start, target, forbidden):
    forbidden = set(forbidden)
    queue = deque([(start, 0, False)])
    visited = set()
    visited.add((start, False))
    while queue:
        node, steps, backward = queue.popleft()
        if node == target:
            return steps

        next_nodes = []
        next_nodes.append(node + 1)
        if not backward and node - 1 >= 0:
            next_nodes.append(node - 1)

        for next_node in next_nodes:
            if 0 <= next_node <= 6000 and next_node not in forbidden:
                if next_node == node + 1:
                    if (next_node, False) not in visited:
                        queue.append((next_node, steps + 1, False))
                        visited.add((next_node, False))
                else:
                    if (next_node, True) not in visited:
                        queue.append((next_node, steps + 1, True))
                        visited.add((next_node, True))
    return -1