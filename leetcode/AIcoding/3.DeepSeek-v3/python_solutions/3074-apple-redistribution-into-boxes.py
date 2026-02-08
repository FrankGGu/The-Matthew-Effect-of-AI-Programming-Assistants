class Solution:
    def minimumBoxes(self, apple: List[int], capacity: List[int]) -> int:
        total_apples = sum(apple)
        capacity.sort(reverse=True)
        boxes = 0
        current_sum = 0
        for cap in capacity:
            if current_sum >= total_apples:
                break
            current_sum += cap
            boxes += 1
        return boxes