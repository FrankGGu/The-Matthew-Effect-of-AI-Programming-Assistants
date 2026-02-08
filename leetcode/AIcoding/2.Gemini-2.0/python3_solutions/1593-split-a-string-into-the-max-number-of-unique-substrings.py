class Solution:
    def maxUniqueSplit(self, s: str) -> int:
        seen = set()
        ans = 0

        def backtrack(start):
            nonlocal ans
            if start == len(s):
                ans = max(ans, len(seen))
                return

            for end in range(start + 1, len(s) + 1):
                sub = s[start:end]
                if sub not in seen:
                    seen.add(sub)
                    backtrack(end)
                    seen.remove(sub)

        backtrack(0)
        return ans