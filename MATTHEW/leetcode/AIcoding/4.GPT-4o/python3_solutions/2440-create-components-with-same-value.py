class Solution:
    def componentValue(self, nums: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict

        def dfs(node, parent):
            total = nums[node]
            for neighbor in graph[node]:
                if neighbor != parent:
                    total += dfs(neighbor, node)
            subtree_sum[node] = total
            return total

        def can_form_components(k):
            target = total_sum // k
            current_sum = 0
            components = 0

            def check(node, parent):
                nonlocal current_sum, components
                current_sum += subtree_sum[node]
                if current_sum == target:
                    components += 1
                    current_sum = 0
                elif current_sum > target:
                    return False

                for neighbor in graph[node]:
                    if neighbor != parent:
                        if not check(neighbor, node):
                            return False
                return True

            return check(0, -1) and components == k

        total_sum = sum(nums)
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        subtree_sum = [0] * len(nums)
        dfs(0, -1)

        max_components = 1
        for k in range(1, total_sum + 1):
            if total_sum % k == 0 and can_form_components(k):
                max_components = k

        return max_components