class Solution:
    def minSubsequence(self, nums: List[int]) -> List[int]:
        total_sum = sum(nums)
        nums.sort(reverse=True)
        subsequence, subseq_sum = [], 0

        for num in nums:
            subsequence.append(num)
            subseq_sum += num
            if subseq_sum > total_sum - subseq_sum:
                break

        return subsequence