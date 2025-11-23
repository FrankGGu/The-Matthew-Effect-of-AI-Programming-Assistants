class Solution:
    def sortEvenOdd(self, nums: List[int]) -> List[int]:
        odd_indices = sorted(nums[i] for i in range(1, len(nums), 2))
        even_indices = sorted(nums[i] for i in range(0, len(nums), 2), reverse=True)

        res = []
        for i in range(len(nums)):
            if i % 2 == 0:
                res.append(even_indices[i // 2])
            else:
                res.append(odd_indices[i // 2])

        return res