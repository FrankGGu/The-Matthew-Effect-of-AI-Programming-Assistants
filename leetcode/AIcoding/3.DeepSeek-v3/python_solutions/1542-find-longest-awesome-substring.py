class Solution:
    def longestAwesome(self, s: str) -> int:
        mask = 0
        mask_dict = {0: -1}
        max_len = 0
        for i, ch in enumerate(s):
            mask ^= 1 << (ord(ch) - ord('0'))
            if mask in mask_dict:
                max_len = max(max_len, i - mask_dict[mask])
            else:
                mask_dict[mask] = i
            for k in range(10):
                temp_mask = mask ^ (1 << k)
                if temp_mask in mask_dict:
                    max_len = max(max_len, i - mask_dict[temp_mask])
        return max_len