class Solution:
    def distMoney(self, money: int, children: int) -> int:
        if money < children:
            return -1

        money -= children
        count = min(money // 7, children)
        remaining_money = money - count * 7
        remaining_children = children - count

        if remaining_children == 0 and remaining_money > 0:
            count -= 1
        elif remaining_children == 1 and remaining_money == 3:
            count -= 1

        return max(count, 0)