class Solution:
    def customSortString(self, order: str, s: str) -> str:
        order_dict = {c: i for i, c in enumerate(order)}
        return ''.join(sorted(s, key=lambda x: order_dict.get(x, 0)))