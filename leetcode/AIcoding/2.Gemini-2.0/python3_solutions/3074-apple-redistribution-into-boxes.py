class Solution:
    def redistributeApples(self, boxSizes: list[int], boxes: int) -> int:
        total_apples = sum(boxSizes)
        apples_per_box = total_apples // boxes
        extra_apples = total_apples % boxes

        result = 0
        for size in boxSizes:
            result += abs(size - apples_per_box)

        return result // 2