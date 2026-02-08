class Solution:
    def check(self, inventory: list[int], article: int) -> bool:
        return all(x >= article for x in inventory)