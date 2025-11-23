class Solution:
    def maximumScore(self, nums: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict
        import heapq

        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        n = len(nums)
        max_score = -1

        for u in range(n):
            for v in graph[u]:
                if u < v:
                    for w in graph[v]:
                        if w != u and w > v:
                            score = nums[u] + nums[v] + nums[w]
                            max_score = max(max_score, score)

        return max_score