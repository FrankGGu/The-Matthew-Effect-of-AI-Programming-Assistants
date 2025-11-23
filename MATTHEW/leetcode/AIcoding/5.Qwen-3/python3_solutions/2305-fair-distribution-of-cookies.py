class Solution:
    def distributeCookies(self, cookies: List[int], k: int) -> int:
        self.min_unfairness = float('inf')
        self.ans = [0] * k

        def backtrack(index):
            if index == len(cookies):
                self.min_unfairness = min(self.min_unfairness, max(self.ans))
                return

            for i in range(k):
                if self.ans[i] + cookies[index] >= self.min_unfairness:
                    continue
                self.ans[i] += cookies[index]
                backtrack(index + 1)
                self.ans[i] -= cookies[index]

        backtrack(0)
        return self.min_unfairness