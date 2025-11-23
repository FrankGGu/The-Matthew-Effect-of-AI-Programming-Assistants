class Solution:
    def smallestMissingValueSubtree(self, parents: List[int], nums: List[int]) -> List[int]:
        n = len(parents)
        children = [[] for _ in range(n)]
        for i in range(1, n):
            children[parents[i]].append(i)

        res = [1] * n
        if 1 not in nums:
            return res

        node = nums.index(1)
        visited = set()
        missing = 1
        while node != -1:
            stack = [node]
            while stack:
                u = stack.pop()
                if nums[u] not in visited:
                    visited.add(nums[u])
                    for v in children[u]:
                        stack.append(v)
            while missing in visited:
                missing += 1
            res[node] = missing
            node = parents[node]
        return res