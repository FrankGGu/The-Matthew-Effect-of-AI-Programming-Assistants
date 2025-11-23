class Solution:
    def canTransform(self, arr: List[int]) -> bool:
        n = len(arr)
        total_sum = sum(arr)
        if total_sum % n != 0:
            return False

        target = total_sum // n
        prefix_sum = 0

        for num in arr:
            prefix_sum += num
            if prefix_sum < 0:
                return False
            if prefix_sum > target:
                return False

        return True