class Solution:
    def maximumValueSum(self, nums: List[int], k: int, edges: List[List[int]]) -> int:
        total = sum(nums)
        diff = [(num ^ k) - num for num in nums]
        diff.sort(reverse=True)

        for i in range(0, len(diff), 2):
            if i + 1 >= len(diff):
                break
            pair_sum = diff[i] + diff[i + 1]
            if pair_sum > 0:
                total += pair_sum
            else:
                break
        return total