class Solution:
    def minimumBoxes(self, apple: list[int], capacity: list[int]) -> int:
        total_apples = sum(apple)
        capacity.sort(reverse=True)

        boxes_used = 0
        current_capacity_sum = 0

        for cap in capacity:
            current_capacity_sum += cap
            boxes_used += 1
            if current_capacity_sum >= total_apples:
                break

        return boxes_used