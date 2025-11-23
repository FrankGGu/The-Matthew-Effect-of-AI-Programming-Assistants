class Solution:
    def canTransform(self, arr: List[int]) -> bool:
        total = sum(arr)
        if total % 3 != 0:
            return False
        target = total // 3
        prefix_sum = 0
        count = 0
        for num in arr:
            prefix_sum += num
            if prefix_sum == target:
                count += 1
                prefix_sum = 0
        return count >= 3