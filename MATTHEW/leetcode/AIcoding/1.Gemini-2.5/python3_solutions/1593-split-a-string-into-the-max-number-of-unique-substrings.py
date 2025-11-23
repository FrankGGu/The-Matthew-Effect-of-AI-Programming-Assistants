class Solution:
    def maxUniqueSplit(self, s: str) -> int:
        self.max_count = 0

        def backtrack(start_index, current_unique_substrings):
            if start_index == len(s):
                self.max_count = max(self.max_count, len(current_unique_substrings))
                return

            for i in range(start_index, len(s)):
                sub = s[start_index : i + 1]

                if sub not in current_unique_substrings:
                    current_unique_substrings.add(sub)
                    backtrack(i + 1, current_unique_substrings)
                    current_unique_substrings.remove(sub)

        backtrack(0, set())
        return self.max_count