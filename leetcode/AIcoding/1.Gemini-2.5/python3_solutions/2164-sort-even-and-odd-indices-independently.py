class Solution:
    def sortEvenOdd(self, nums: list[int]) -> list[int]:
        n = len(nums)
        if n <= 1:
            return nums

        even_indexed_elements = []
        odd_indexed_elements = []

        for i in range(n):
            if i % 2 == 0:
                even_indexed_elements.append(nums[i])
            else:
                odd_indexed_elements.append(nums[i])

        even_indexed_elements.sort()
        odd_indexed_elements.sort(reverse=True)

        result = [0] * n
        even_ptr = 0
        odd_ptr = 0

        for i in range(n):
            if i % 2 == 0:
                result[i] = even_indexed_elements[even_ptr]
                even_ptr += 1
            else:
                result[i] = odd_indexed_elements[odd_ptr]
                odd_ptr += 1

        return result