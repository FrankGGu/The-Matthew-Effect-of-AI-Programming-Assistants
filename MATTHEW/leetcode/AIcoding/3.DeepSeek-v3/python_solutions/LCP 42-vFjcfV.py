class Solution:
    def toyCircle(self, toys: List[List[int]], circles: List[List[int]], r: int) -> int:
        count = 0
        r_squared = r * r
        for x, y in circles:
            for tx, ty in toys:
                dx = tx - x
                dy = ty - y
                if dx * dx + dy * dy <= r_squared:
                    count += 1
                    break
        return count