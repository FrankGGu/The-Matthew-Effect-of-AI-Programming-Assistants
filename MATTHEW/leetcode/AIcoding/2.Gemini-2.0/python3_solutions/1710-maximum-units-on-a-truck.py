class Solution:
    def maximumUnits(self, boxTypes: List[List[int]], truckSize: int) -> int:
        boxTypes.sort(key=lambda x: x[1], reverse=True)
        units = 0
        for boxes, unit in boxTypes:
            if truckSize >= boxes:
                units += boxes * unit
                truckSize -= boxes
            else:
                units += truckSize * unit
                break
        return units