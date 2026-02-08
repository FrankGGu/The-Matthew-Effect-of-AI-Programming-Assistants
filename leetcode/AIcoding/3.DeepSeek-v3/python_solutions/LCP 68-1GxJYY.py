class Solution:
    def beautifulBouquet(self, flowers: List[int], cnt: int) -> int:
        from collections import defaultdict
        mod = 10**9 + 7
        left = 0
        res = 0
        freq = defaultdict(int)

        for right in range(len(flowers)):
            freq[flowers[right]] += 1
            while freq[flowers[right]] > cnt:
                freq[flowers[left]] -= 1
                left += 1
            res += right - left + 1
            res %= mod

        return res