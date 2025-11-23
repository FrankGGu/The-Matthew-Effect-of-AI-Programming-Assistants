class Solution:
    def numberOfAlternatingGroups(self, colors: List[int]) -> int:
        n = len(colors)
        count = 0
        for i in range(n):
            prev = colors[i - 1] if i > 0 else colors[-1]
            curr = colors[i]
            next_val = colors[(i + 1) % n]
            if prev != curr and curr != next_val:
                count += 1
        return count