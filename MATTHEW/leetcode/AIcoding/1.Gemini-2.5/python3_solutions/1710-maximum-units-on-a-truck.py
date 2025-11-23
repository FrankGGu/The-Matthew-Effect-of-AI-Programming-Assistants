class Solution:
    def maximumUnits(self, boxTypes: list[list[int]], truckSize: int) -> int:
        boxTypes.sort(key=lambda x: x[1], reverse=True)

        total_units = 0
        for num_boxes, units_per_box in boxTypes:
            if truckSize == 0:
                break

            boxes_to_take = min(num_boxes, truckSize)
            total_units += boxes_to_take * units_per_box
            truckSize -= boxes_to_take

        return total_units