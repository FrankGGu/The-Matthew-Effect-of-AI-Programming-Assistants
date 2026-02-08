from typing import List

class Solution:
    def circularArrayLoop(self, nums: List[int]) -> bool:
        n = len(nums)

        def get_next_idx(current_idx: int, forward_direction: bool) -> int:
            val = nums[current_idx]

            if val == 0:
                return -1

            current_direction = val > 0
            if current_direction != forward_direction:
                return -1

            next_idx = (current_idx + val) % n

            if next_idx == current_idx:
                return -1

            return next_idx

        for i in range(n):
            if nums[i] == 0:
                continue

            slow = i
            fast = i
            forward = nums[i] > 0 

            while True:
                slow = get_next_idx(slow, forward)
                if slow == -1:
                    break

                fast = get_next_idx(fast, forward)
                if fast == -1:
                    break

                fast = get_next_idx(fast, forward)
                if fast == -1:
                    break

                if slow == fast:
                    return True

            curr = i
            while True:
                next_node = get_next_idx(curr, forward)
                nums[curr] = 0 

                if next_node == -1 or nums[next_node] == 0:
                    break
                curr = next_node

        return False