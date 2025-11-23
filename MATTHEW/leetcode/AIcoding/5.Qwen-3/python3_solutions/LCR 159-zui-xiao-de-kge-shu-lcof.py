class Solution:
    def inventoryManagement(self, cnt: int, values: list[int]) -> int:
        if cnt == 0:
            return 0
        values.sort()
        return values[cnt // 2]