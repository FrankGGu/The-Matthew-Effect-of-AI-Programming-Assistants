class Solution:
    def countBuildings(self, heights: List[int]) -> int:
        count = 0
        max_height = 0
        for height in heights:
            if height > max_height:
                count += 1
                max_height = height
        return count