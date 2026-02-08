class Solution:
    def distributeCookies(self, cookies: list[int], k: int) -> int:
        self.min_unfairness = float('inf')
        self.children_cookies = [0] * k
        n = len(cookies)

        def backtrack(cookie_idx):
            if cookie_idx == n:
                self.min_unfairness = min(self.min_unfairness, max(self.children_cookies))
                return

            for child_id in range(k):
                was_empty = (self.children_cookies[child_id] == 0)

                self.children_cookies[child_id] += cookies[cookie_idx]

                if self.children_cookies[child_id] >= self.min_unfairness:
                    self.children_cookies[child_id] -= cookies[cookie_idx]
                    continue

                backtrack(cookie_idx + 1)

                self.children_cookies[child_id] -= cookies[cookie_idx]

                if was_empty:
                    break

        backtrack(0)
        return self.min_unfairness