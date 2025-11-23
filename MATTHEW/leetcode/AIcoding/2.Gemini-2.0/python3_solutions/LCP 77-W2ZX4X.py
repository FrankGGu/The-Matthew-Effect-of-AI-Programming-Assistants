class Solution:
    def runeReserve(self, runes: list[int]) -> int:
        runes.sort()
        n = len(runes)
        ans = 1
        cnt = 1
        for i in range(1, n):
            if runes[i] == runes[i - 1] + 1:
                cnt += 1
            else:
                cnt = 1
            ans = max(ans, cnt)
        return ans