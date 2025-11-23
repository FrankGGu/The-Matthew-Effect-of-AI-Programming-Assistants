class Solution:
    def sortEvenOdd(self, nums: List[int]) -> List[int]:
        even = sorted([nums[i] for i in range(0, len(nums), 2)])
        odd = sorted([nums[i] for i in range(1, len(nums), 2)], reverse=True)

        result = []
        even_idx = 0
        odd_idx = 0

        for i in range(len(nums)):
            if i % 2 == 0:
                if even_idx < len(even):
                    result.append(even[even_idx])
                    even_idx += 1
            else:
                if odd_idx < len(odd):
                    result.append(odd[odd_idx])
                    odd_idx += 1

        return result