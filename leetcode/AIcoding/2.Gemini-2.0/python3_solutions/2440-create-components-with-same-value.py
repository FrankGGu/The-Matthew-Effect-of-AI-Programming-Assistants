class Solution:
    def componentValue(self, nums: List[int], edges: List[List[int]]) -> int:
        total_sum = sum(nums)
        n = len(nums)

        def can_split(k):
            if total_sum % k != 0:
                return False
            target = total_sum // k
            visited = [False] * n
            graph = [[] for _ in range(n)]
            for u, v in edges:
                graph[u].append(v)
                graph[v].append(u)

            def dfs(node):
                visited[node] = True
                curr_sum = nums[node]
                for neighbor in graph[node]:
                    if not visited[neighbor]:
                        curr_sum += dfs(neighbor)
                if curr_sum > target:
                    return float('inf')
                elif curr_sum == target:
                    return 0
                else:
                    return curr_sum

            count = 0
            for i in range(n):
                if not visited[i]:
                    res = dfs(i)
                    if res != 0:
                        return False
                    count += 1
            return True

        for k in range(min(total_sum, n), 0, -1):
            if can_split(k):
                return k - 1
        return 0