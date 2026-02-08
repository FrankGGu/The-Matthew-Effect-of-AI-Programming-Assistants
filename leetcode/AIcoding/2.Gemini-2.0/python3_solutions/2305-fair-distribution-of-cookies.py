class Solution:
    def distributeCookies(self, cookies: List[int], k: int) -> int:
        n = len(cookies)
        unfairness = float('inf')
        children = [0] * k

        def backtrack(index):
            nonlocal unfairness
            if index == n:
                unfairness = min(unfairness, max(children))
                return

            for i in range(k):
                children[i] += cookies[index]
                backtrack(index + 1)
                children[i] -= cookies[index]
                if children[i] == 0:
                    break

        backtrack(0)
        return unfairness