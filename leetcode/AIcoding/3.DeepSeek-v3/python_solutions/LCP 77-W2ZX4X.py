class Solution:
    def runeReserve(self, runes: List[int]) -> int:
        if not runes:
            return 0
        runes.sort()
        max_count = 1
        current_count = 1
        for i in range(1, len(runes)):
            if runes[i] - runes[i-1] <= 1:
                current_count += 1
                max_count = max(max_count, current_count)
            else:
                current_count = 1
        return max_count