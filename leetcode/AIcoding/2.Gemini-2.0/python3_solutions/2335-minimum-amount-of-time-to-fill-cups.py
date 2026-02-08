class Solution:
    def fillCups(self, amount: List[int]) -> int:
        amount.sort()
        a, b, c = amount[0], amount[1], amount[2]
        if a + b <= c:
            return c
        else:
            return (a + b + c + 1) // 2