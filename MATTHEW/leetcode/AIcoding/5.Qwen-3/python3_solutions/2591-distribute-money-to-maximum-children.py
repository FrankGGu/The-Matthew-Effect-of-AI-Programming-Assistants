class Solution:
    def distributeMoney(self, money: int, children: int) -> int:
        if money < children:
            return 0
        if money == children:
            return 1
        if children == 1:
            return money
        max_per_child = money // children
        remainder = money % children
        if remainder == 0:
            return max_per_child
        else:
            return max_per_child