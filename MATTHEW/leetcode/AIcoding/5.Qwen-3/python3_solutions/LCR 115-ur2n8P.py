from collections import deque, defaultdict

class Solution:
    def sequenceReconstruction(self, nums: List[int], sequences: List[List[int]]) -> bool:
        graph = defaultdict(list)
        in_degree = defaultdict(int)

        for seq in sequences:
            for i in range(len(seq) - 1):
                src, dst = seq[i], seq[i + 1]
                graph[src].append(dst)
                in_degree[dst] += 1

        queue = deque()
        for num in nums:
            if in_degree[num] == 0:
                queue.append(num)

        while queue:
            if len(queue) > 1:
                return False
            current = queue.popleft()
            for neighbor in graph[current]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return True