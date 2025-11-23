from collections import Counter
from functools import lru_cache
from typing import List

class Solution:
    def minStickers(self, stickers: str, target: str) -> int:
        target_count = Counter(target)
        sticker_counts = [Counter(sticker) for sticker in stickers]

        @lru_cache(None)
        def dp(mask):
            if mask == (1 << len(target)) - 1:
                return 0
            res = float('inf')
            for sticker in sticker_counts:
                new_mask = mask
                for i, c in enumerate(target):
                    if (new_mask >> i) & 1:
                        continue
                    if sticker[c] > 0:
                        new_mask |= 1 << i
                        sticker[c] -= 1
                if new_mask != mask:
                    res = min(res, 1 + dp(new_mask))
                for i, c in enumerate(target):
                    if (new_mask >> i) & 1:
                        sticker[c] += 1
            return res

        result = dp(0)
        return result if result != float('inf') else -1