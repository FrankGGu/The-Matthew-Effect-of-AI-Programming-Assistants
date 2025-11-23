class Solution:
    def distributeCookies(self, cookies: List[int], k: int) -> int:
        min_unfairness = float('inf')
        distribution = [0] * k

        def backtrack(index):
            nonlocal min_unfairness
            if index == len(cookies):
                current_max = max(distribution)
                if current_max < min_unfairness:
                    min_unfairness = current_max
                return

            for i in range(k):
                if distribution[i] + cookies[index] >= min_unfairness:
                    continue
                distribution[i] += cookies[index]
                backtrack(index + 1)
                distribution[i] -= cookies[index]

        backtrack(0)
        return min_unfairness