class Solution:
    def minimumSize(self, nums: List[int], maxOperations: int) -> int:
        left, right = 1, max(nums)
        answer = right

        while left <= right:
            mid = (left + right) // 2
            operations = 0
            for num in nums:
                operations += (num - 1) // mid
                if operations > maxOperations:
                    break

            if operations <= maxOperations:
                answer = mid
                right = mid - 1
            else:
                left = mid + 1

        return answer