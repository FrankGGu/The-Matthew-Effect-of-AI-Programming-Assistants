from collections import defaultdict, deque

class Solution:
    def sequenceReconstruction(self, org, seqs):
        graph = defaultdict(list)
        indegree = {}
        nodes = set()

        for seq in seqs:
            for num in seq:
                nodes.add(num)
                indegree[num] = 0

        for seq in seqs:
            for i in range(len(seq)):
                if i > 0:
                    graph[seq[i-1]].append(seq[i])
                    indegree[seq[i]] += 1

        if len(nodes) != len(org):
            return False

        queue = deque([node for node in nodes if indegree[node] == 0])
        reconstructed = []

        while queue:
            if len(queue) > 1:
                return False

            node = queue.popleft()
            reconstructed.append(node)

            for neighbor in graph[node]:
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)

        if len(reconstructed) != len(nodes):
            return False

        return reconstructed == org