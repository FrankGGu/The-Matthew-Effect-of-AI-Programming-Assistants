class Solution:
    def countBeautifulSubstrings(self, s: str) -> int:
        n = len(s)
        count = 0
        prefix_count = {0: 1}
        current_count = 0

        for i in range(n):
            if s[i] == '1':
                current_count += 1
            else:
                current_count -= 1

            if current_count in prefix_count:
                count += prefix_count[current_count]
                prefix_count[current_count] += 1
            else:
                prefix_count[current_count] = 1

        return count