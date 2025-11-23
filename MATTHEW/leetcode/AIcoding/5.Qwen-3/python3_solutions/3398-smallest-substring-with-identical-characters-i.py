class Solution:
    def smallestSubstring(self, s: str) -> str:
        from collections import defaultdict

        char_count = defaultdict(int)
        left = 0
        min_length = float('inf')
        result = ""

        for right in range(len(s)):
            char_count[s[right]] += 1

            while len(char_count) > 1:
                if char_count[s[left]] > 1:
                    char_count[s[left]] -= 1
                    left += 1
                else:
                    break

            if len(char_count) == 1:
                current_length = right - left + 1
                if current_length < min_length:
                    min_length = current_length
                    result = s[left:right+1]

        return result