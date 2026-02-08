from collections import defaultdict

class Solution:
    def countGoodSubarrays(self, nums: List[int], k: int) -> int:
        count = 0
        prefix_xor = 0
        freq = defaultdict(int)
        freq[0] = 1
        for num in nums:
            prefix_xor ^= num
            for xor_val, cnt in freq.items():
                if (prefix_xor ^ xor_val) >= k:
                    count += cnt
            freq[prefix_xor] += 1
        return count