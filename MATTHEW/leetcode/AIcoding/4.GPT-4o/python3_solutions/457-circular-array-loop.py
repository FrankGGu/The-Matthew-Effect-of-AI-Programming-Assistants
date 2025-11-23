class Solution:
    def circularArrayLoop(self, nums: List[int]) -> bool:
        n = len(nums)

        for i in range(n):
            slow, fast = i, i
            sign = nums[i] > 0

            while True:
                slow = (slow + nums[slow]) % n
                fast = (fast + nums[fast]) % n
                fast = (fast + nums[fast]) % n

                if slow == fast:
                    if slow == (slow + nums[slow]) % n:  # check for single-element loops
                        break
                    return True

                if nums[slow] > 0 != sign or nums[fast] > 0 != sign:
                    break

        return False