class Solution:
    def distributeCookies(self, cookies: List[int], k: int) -> int:
        def backtrack(start, children):
            if start == len(cookies):
                return max(children)
            min_unfair = float('inf')
            for i in range(k):
                children[i] += cookies[start]
                min_unfair = min(min_unfair, backtrack(start + 1, children))
                children[i] -= cookies[start]
                if children[i] == 0:
                    break
            return min_unfair

        return backtrack(0, [0] * k)