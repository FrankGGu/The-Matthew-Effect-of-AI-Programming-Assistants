class Solution:
    def customSortString(self, order: str, s: str) -> str:
        order_map = {c: i for i, c in enumerate(order)}

        def sort_key(char):
            return order_map.get(char, len(order))

        return "".join(sorted(s, key=sort_key))