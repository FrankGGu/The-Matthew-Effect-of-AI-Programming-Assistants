class Solution:
    def stoneGameIX(self, stones: List[int]) -> bool:
        cnt0 = stones.count(0)
        cnt1 = stones.count(1)
        cnt2 = stones.count(2)
        if cnt0 % 2 == 0:
            return cnt1 >= 1 and cnt2 >= 1
        else:
            return abs(cnt1 - cnt2) > 2