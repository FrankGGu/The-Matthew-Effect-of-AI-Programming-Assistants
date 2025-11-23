class Solution:
    def inventoryManagement(self, stock: List[int], cnt: int) -> List[int]:
        if cnt == 0:
            return []
        return sorted(stock)[:cnt]