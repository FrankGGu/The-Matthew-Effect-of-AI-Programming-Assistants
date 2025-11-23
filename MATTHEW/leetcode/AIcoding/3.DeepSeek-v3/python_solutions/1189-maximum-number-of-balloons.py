class Solution:
    def maxNumberOfBalloons(self, text: str) -> int:
        from collections import defaultdict

        balloon = defaultdict(int)
        for c in 'balloon':
            balloon[c] += 1

        count = defaultdict(int)
        for c in text:
            count[c] += 1

        max_num = float('inf')
        for c in balloon:
            if c == 'l' or c == 'o':
                max_num = min(max_num, count[c] // 2)
            else:
                max_num = min(max_num, count[c])

        return max_num