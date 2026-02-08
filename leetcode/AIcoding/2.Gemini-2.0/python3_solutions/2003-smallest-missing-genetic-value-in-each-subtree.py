class Solution:
    def smallestMissingValueSubtree(self, parents: list[int], nums: list[int]) -> list[int]:
        n = len(parents)
        children = [[] for _ in range(n)]
        for i in range(1, n):
            children[parents[i]].append(i)

        result = [1] * n

        def dfs(node, visited):
            visited.add(nums[node])
            for child in children[node]:
                dfs(child, visited)

        node = -1
        for i in range(n):
            if nums[i] == 1:
                node = i
                break

        if node == -1:
            return result

        missing = 1
        visited = set()

        while node != -1:
            dfs(node, visited)
            while missing in visited:
                missing += 1
            result[node] = missing
            node = parents[node]

        return result