class Solution:
    def maxSubsequence(self, nums: List[int], k: int) -> List[int]:
        indexed_nums = [(num, i) for i, num in enumerate(nums)]
        indexed_nums.sort(key=lambda x: (-x[0], x[1]))
        top_k = indexed_nums[:k]
        top_k.sort(key=lambda x: x[1])
        return [num for num, i in top_k]