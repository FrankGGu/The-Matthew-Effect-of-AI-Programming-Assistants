class Solution:
    def findColumnWidth(self, grid: List[List[int]]) -> List[int]:
        max_widths = []
        for col in zip(*grid):
            max_len = 0
            for num in col:
                current_len = len(str(num))
                if current_len > max_len:
                    max_len = current_len
            max_widths.append(max_len)
        return max_widths