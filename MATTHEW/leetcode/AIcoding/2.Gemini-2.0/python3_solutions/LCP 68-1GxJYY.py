class Solution:
    def beautifulBouquet(self, flowers: list[int], cnt: int) -> int:
        MOD = 10**9 + 7
        n = len(flowers)
        left = 0
        freq = {}
        ans = 0

        for right in range(n):
            flower = flowers[right]
            freq[flower] = freq.get(flower, 0) + 1

            while freq[flower] > cnt:
                freq[flowers[left]] -= 1
                left += 1

            ans = (ans + (right - left + 1)) % MOD

        return ans