class Solution:
    def minDeletions(self, nums: list[int]) -> int:
        beautiful_array = []
        deletions = 0

        for num in nums:
            if len(beautiful_array) % 2 == 0:
                # We are looking for an element at an even index (0, 2, 4, ...)
                # Any number can be placed at an even index.
                beautiful_array.append(num)
            else:
                # We are looking for an element at an odd index (1, 3, 5, ...)
                # This element must be different from the previous one.
                if beautiful_array[-1] == num:
                    # If it's the same, we must delete the current number.
                    deletions += 1
                else:
                    # If it's different, we can add it.
                    beautiful_array.append(num)

        # After processing all numbers, if the beautiful_array has an odd length,
        # its last element cannot form a pair, so it must be deleted to satisfy
        # the "even length" condition.
        if len(beautiful_array) % 2 != 0:
            deletions += 1

        return deletions