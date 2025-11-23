class Solution:
    def minStickers(self, stickers: List[str], target: str) -> int:
        n = len(target)
        dp = {}
        dp[""] = 0

        def solve(mask):
            if mask in dp:
                return dp[mask]

            dp[mask] = float('inf')
            for sticker in stickers:
                new_mask = mask
                sticker_counts = {}
                for char in sticker:
                    sticker_counts[char] = sticker_counts.get(char, 0) + 1

                temp_mask = ""
                for i in range(len(target)):
                    if (mask >> i) & 1:
                        temp_mask += target[i]

                new_target = ""
                temp_mask_arr = []
                for i in range(len(temp_mask)):
                    if temp_mask[i] in sticker_counts and sticker_counts[temp_mask[i]] > 0:
                        sticker_counts[temp_mask[i]] -= 1
                    else:
                        new_target += temp_mask[i]
                        temp_mask_arr.append(i)

                next_mask = 0
                for i in range(len(new_target)):
                    original_index = 0
                    count = 0
                    for j in range(len(target)):
                        if (mask >> j) & 1:
                            if count == temp_mask_arr[i]:
                                original_index = j
                                break
                            count += 1

                    next_mask |= (1 << original_index)