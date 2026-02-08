class Solution:
    def rob(self, nums: list[int]) -> int:
        rob1 = 0
        rob2 = 0

        # rob1: max money if we don't rob current house (i.e., money from previous house)
        # rob2: max money if we rob current house (i.e., money from current house + money from house i-2)
        # We want to find the maximum of these two options for each house.
        for n in nums:
            # new_rob2 is the maximum money we can have up to the current house 'n'
            # It's either:
            # 1. Rob current house 'n': n + rob1 (cannot rob previous house, so add money from two houses ago)
            # 2. Don't rob current house 'n': rob2 (just take the max money from the previous house)
            temp = max(n + rob1, rob2)

            # Update rob1 to be the previous rob2
            rob1 = rob2

            # Update rob2 to be the current maximum (temp)
            rob2 = temp

        # rob2 will hold the maximum money after iterating through all houses
        return rob2