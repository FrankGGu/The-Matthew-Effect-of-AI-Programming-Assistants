class Solution:
    def maxSubsequence(self, nums: List[int], k: int) -> List[int]:
        indexed_nums = []
        for i, num in enumerate(nums):
            indexed_nums.append((num, i))

        indexed_nums.sort(key=lambda x: x[0], reverse=True)

        top_k_elements = indexed_nums[:k]

        top_k_elements.sort(key=lambda x: x[1])

        result = [val for val, _ in top_k_elements]

        return result