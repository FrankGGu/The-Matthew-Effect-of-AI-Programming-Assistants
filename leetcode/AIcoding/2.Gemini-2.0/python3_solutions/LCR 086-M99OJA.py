class Solution:
    def partition(self, s: str) -> list[list[str]]:
        result = []

        def is_palindrome(sub):
            return sub == sub[::-1]

        def backtrack(start, current_partition):
            if start == len(s):
                result.append(current_partition[:])
                return

            for i in range(start, len(s)):
                sub = s[start:i + 1]
                if is_palindrome(sub):
                    current_partition.append(sub)
                    backtrack(i + 1, current_partition)
                    current_partition.pop()

        backtrack(0, [])
        return result