class Solution:
    def maxAltitude(self, heights: List[int], k: int) -> List[int]:
        if not heights or k == 0:
            return []

        n = len(heights)
        if k >= n:
            return [max(heights)]

        result = []
        window = []

        for i in range(n):
            while window and window[0] < i - k + 1:
                window.pop(0)

            while window and heights[window[-1]] < heights[i]:
                window.pop()

            window.append(i)

            if i >= k - 1:
                result.append(heights[window[0]])

        return result