class Solution:
    def inventoryManagement(self, stock: List[int]) -> int:
        candidate, count = None, 0
        for num in stock:
            if count == 0:
                candidate = num
                count = 1
            else:
                count += 1 if candidate == num else -1
        return candidate