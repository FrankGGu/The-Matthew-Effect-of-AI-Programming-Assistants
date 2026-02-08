class Solution:
    def smallestSubstringWithIdenticalCharacters(self, s: str, k: int) -> int:
        n = len(s)

        current_run_length = 0

        for i in range(n):
            if i > 0 and s[i] == s[i-1]:
                current_run_length += 1
            else:
                current_run_length = 1

            if current_run_length >= k:
                return k

        return -1