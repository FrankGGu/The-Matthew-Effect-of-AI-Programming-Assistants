class Solution:
    def maxNumOfSubstrings(self, s: str) -> List[str]:
        n = len(s)
        left = [0] * n
        right = [0] * n
        last = {}

        for i in range(n):
            last[s[i]] = i

        min_end = n
        for i in range(n - 1, -1, -1):
            min_end = min(min_end, last[s[i]])
            right[i] = min_end

        max_start = -1
        for i in range(n):
            if right[i] == 0:
                continue
            max_start = max(max_start, i)
            left[i] = max_start

        result = []
        for i in range(n):
            if right[i] > 0 and left[i] <= i:
                result.append(s[left[i]:right[i] + 1])

        return result