class Solution:
    def distMoney(self, money: int, children: int) -> int:
        if money < children:
            return -1

        money -= children

        ans = min(money // 7, children)
        money -= ans * 7
        children -= ans

        if children == 0:
            if money > 0:
                ans -= 1
        elif children == 1 and money == 3:
            ans -= 1

        return ans