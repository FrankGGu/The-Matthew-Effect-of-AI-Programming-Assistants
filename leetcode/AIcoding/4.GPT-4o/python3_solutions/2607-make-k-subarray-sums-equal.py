class Solution:
    def makeKSubarraySumsEqual(self, arr: List[int], k: int) -> bool:
        total_sum = sum(arr)
        if total_sum % k != 0:
            return False
        target_sum = total_sum // k
        current_sum = 0
        subarray_count = 0

        for num in arr:
            current_sum += num
            if current_sum == target_sum:
                subarray_count += 1
                current_sum = 0
            elif current_sum > target_sum:
                return False

        return subarray_count == k