class Solution:
    def fileCombination(self, target: int) -> List[List[int]]:
        left, right = 1, 1
        current_sum = 0
        res = []
        while left <= target // 2:
            if current_sum < target:
                current_sum += right
                right += 1
            elif current_sum > target:
                current_sum -= left
                left += 1
            else:
                res.append(list(range(left, right)))
                current_sum -= left
                left += 1
        return res