class Solution:
    def circularArrayLoop(self, nums: list[int]) -> bool:
        n = len(nums)

        def check(i, positive):
            slow = fast = i
            while True:
                slow = next_index(slow)
                fast = next_index(next_index(fast))

                if slow == -1 or fast == -1:
                    return False

                if slow == fast:
                    if slow == next_index(slow):
                        return False
                    return True

        def next_index(i):
            direction = nums[i] > 0

            next_idx = (i + nums[i]) % n

            if next_idx < 0:
                next_idx += n

            if (nums[next_idx] > 0) != direction:
                return -1

            return next_idx

        for i in range(n):
            if check(i, nums[i] > 0):
                return True
        return False