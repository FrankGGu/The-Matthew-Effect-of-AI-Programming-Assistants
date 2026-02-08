class Solution:
    def maxDistance(self, colors: List[int]) -> int:
        left, right = 0, len(colors) - 1
        while colors[left] == colors[right]:
            if colors[left] == colors[0]:
                left += 1
            else:
                right -= 1
        return max(right, len(colors) - 1 - left)