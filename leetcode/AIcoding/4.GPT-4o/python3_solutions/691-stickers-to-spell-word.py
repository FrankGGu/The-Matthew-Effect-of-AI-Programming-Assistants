from collections import Counter

class Solution:
    def minStickers(self, stickers: List[str], target: str) -> int:
        target_count = Counter(target)
        sticker_counts = [Counter(sticker) for sticker in stickers]
        n = len(sticker_counts)

        dp = {}

        def dfs(remaining):
            if not remaining:
                return 0
            if remaining in dp:
                return dp[remaining]

            remaining_count = Counter(remaining)
            min_stickers = float('inf')

            for sticker_count in sticker_counts:
                if sticker_count[remaining[0]] == 0:
                    continue

                new_remaining = []
                for char in remaining_count:
                    if remaining_count[char] > sticker_count[char]:
                        new_remaining.append(char * (remaining_count[char] - sticker_count[char]))

                new_remaining_str = ''.join(new_remaining)
                min_stickers = min(min_stickers, 1 + dfs(new_remaining_str))

            dp[remaining] = min_stickers
            return min_stickers

        result = dfs(target)
        return result if result != float('inf') else -1