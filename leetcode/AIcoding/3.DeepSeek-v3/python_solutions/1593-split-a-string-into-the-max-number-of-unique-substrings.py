class Solution:
    def maxUniqueSplit(self, s: str) -> int:
        self.max_count = 0
        n = len(s)

        def backtrack(start, seen):
            if start == n:
                self.max_count = max(self.max_count, len(seen))
                return
            for end in range(start + 1, n + 1):
                substring = s[start:end]
                if substring not in seen:
                    seen.add(substring)
                    backtrack(end, seen)
                    seen.remove(substring)

        backtrack(0, set())
        return self.max_count