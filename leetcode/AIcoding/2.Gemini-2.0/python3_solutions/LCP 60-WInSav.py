class Solution:
    def removeBoxes(self, boxes: List[int]) -> int:
        n = len(boxes)
        memo = {}

        def calculate_points(l, r, k):
            if l > r:
                return 0
            if (l, r, k) in memo:
                return memo[(l, r, k)]

            while l < r and boxes[l] == boxes[l + 1]:
                l += 1
                k += 1

            res = (k + 1) * (k + 1) + calculate_points(l + 1, r, 0)

            for i in range(l + 1, r + 1):
                if boxes[i] == boxes[l]:
                    res = max(res, calculate_points(l + 1, i - 1, 0) + calculate_points(i, r, k + 1))

            memo[(l, r, k)] = res
            return res

        return calculate_points(0, n - 1, 0)