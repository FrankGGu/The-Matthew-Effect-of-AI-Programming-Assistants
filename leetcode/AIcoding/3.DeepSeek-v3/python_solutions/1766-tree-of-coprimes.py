import math
from collections import deque

class Solution:
    def getCoprimes(self, nums: List[int], edges: List[List[int]]) -> List[int]:
        n = len(nums)
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        # Precompute coprimes for each number in nums
        coprimes = {}
        unique_nums = set(nums)
        for num in unique_nums:
            coprimes[num] = []
            for other in unique_nums:
                if math.gcd(num, other) == 1:
                    coprimes[num].append(other)

        res = [-1] * n
        # Each stack keeps track of (node, depth) for a specific value
        stacks = {}
        stack = []

        def dfs(node, parent, depth):
            nonlocal stack, stacks
            current_num = nums[node]
            max_depth = -1
            best_ancestor = -1
            # Check all coprimes of current_num
            for coprime in coprimes.get(current_num, []):
                if coprime in stacks and stacks[coprime]:
                    last_node, last_depth = stacks[coprime][-1]
                    if last_depth > max_depth:
                        max_depth = last_depth
                        best_ancestor = last_node
            res[node] = best_ancestor

            # Push current node to its num's stack
            if current_num not in stacks:
                stacks[current_num] = []
            stacks[current_num].append((node, depth))

            for neighbor in graph[node]:
                if neighbor != parent:
                    dfs(neighbor, node, depth + 1)

            # Pop current node from its num's stack
            stacks[current_num].pop()

        dfs(0, -1, 0)
        return res