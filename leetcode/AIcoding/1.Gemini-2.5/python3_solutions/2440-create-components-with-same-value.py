import sys

class Solution:
    def componentValue(self, nums: list[int], edges: list[list[int]]) -> int:
        n = len(nums)

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        total_sum = sum(nums)

        def get_divisors(num):
            divs = set()
            for i in range(1, int(num**0.5) + 1):
                if num % i == 0:
                    divs.add(i)
                    divs.add(num // i)
            return sorted(list(divs))

        possible_sums = get_divisors(total_sum)

        sys.setrecursionlimit(n + 100)

        def dfs(u, p, target_sum):
            current_subtree_sum = nums[u]

            for v in adj[u]:
                if v == p:
                    continue

                child_result = dfs(v, u, target_sum)

                if child_result == -1:
                    return -1

                current_subtree_sum += child_result

            if current_subtree_sum > target_sum:
                return -1

            if current_subtree_sum == target_sum:
                return 0

            return current_subtree_sum

        for s in possible_sums:
            result_from_root = dfs(0, -1, s)
            if result_from_root == 0:
                return total_sum // s

        return 1