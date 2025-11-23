from collections import Counter
from functools import lru_cache

class Solution:
    def minStickers(self, stickers: list[str], target: str) -> int:
        stickers = [''.join(sorted(s)) for s in stickers]
        n = len(target)
        target = ''.join(sorted(target))

        @lru_cache(None)
        def solve(t):
            if not t:
                return 0

            ans = float('inf')
            for sticker in stickers:
                if sticker[0] not in t:
                    continue

                new_t = ""
                sticker_counts = Counter(sticker)
                target_counts = Counter(t)

                for char in target_counts:
                    need = target_counts[char]
                    have = sticker_counts[char] if char in sticker_counts else 0

                    if have < need:
                        new_t += char * (need - have)

                new_t = ''.join(sorted(new_t))

                temp = solve(new_t)
                if temp != float('inf'):
                    ans = min(ans, 1 + temp)

            return ans

        res = solve(target)
        return res if res != float('inf') else -1