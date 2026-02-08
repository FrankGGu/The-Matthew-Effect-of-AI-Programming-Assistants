class Solution:
    def totalSteps(self, nums: list[int]) -> int:
        n = len(nums)
        if n <= 1:
            return 0

        ans = 0
        # stack stores (value, steps_count)
        # steps_count for a value represents the number of steps it takes for this value
        # to be removed by its left neighbor. If it's not removed, it's 0.
        stack = []

        for num in nums:
            current_steps = 0
            # Pop elements from stack that are less than or equal to the current num.
            # These elements are either removed by num (if strictly less) or
            # num is not removed by them (if equal).
            while stack and stack[-1][0] <= num:
                prev_val, prev_steps = stack.pop()
                if prev_val < num:
                    # If prev_val is strictly smaller, num effectively causes its removal.
                    # The number of steps for num to be removed (by its left neighbor)
                    # must be at least the steps prev_val took to be removed.
                    current_steps = max(current_steps, prev_steps)
                else: # prev_val == num
                    # If prev_val is equal to num, then num is not removed by prev_val.
                    # It also means num does not extend the removal chain of prev_val.
                    # So, current_steps for num should be 0.
                    current_steps = 0
                    break # Stop processing further left, as num is not removed by prev_val

            # After the loop, if the stack is not empty, it means stack[-1][0] > num.
            # In this case, num will be removed by stack[-1][0].
            # The number of steps it takes for num to be removed is current_steps + 1.
            if stack:
                current_steps += 1
                ans = max(ans, current_steps)
                stack.append((num, current_steps))
            else:
                # If the stack is empty, num is the largest element encountered so far,
                # or it was equal to its effective left neighbor (due to the 'break').
                # In either scenario, num is not removed by anything to its left,
                # so its steps_count is 0.
                stack.append((num, 0))

        return ans