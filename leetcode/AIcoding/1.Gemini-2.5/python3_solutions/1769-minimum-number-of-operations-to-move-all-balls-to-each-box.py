class Solution:
    def minOperations(self, boxes: str) -> list[int]:
        n = len(boxes)
        ans = [0] * n

        # First pass: calculate operations for balls to the left of each box
        # and accumulate them.
        # cost_from_left: total operations to move all balls encountered so far to the current box.
        # balls_to_left: count of balls encountered so far.
        balls_to_left = 0
        cost_from_left = 0
        for i in range(n):
            ans[i] += cost_from_left
            if boxes[i] == '1':
                balls_to_left += 1
            cost_from_left += balls_to_left

        # Second pass: calculate operations for balls to the right of each box
        # and accumulate them.
        # cost_from_right: total operations to move all balls encountered so far (from right to left)
        #                  to the current box.
        # balls_to_right: count of balls encountered so far (from right to left).
        balls_to_right = 0
        cost_from_right = 0
        for i in range(n - 1, -1, -1):
            ans[i] += cost_from_right
            if boxes[i] == '1':
                balls_to_right += 1
            cost_from_right += balls_to_right

        return ans