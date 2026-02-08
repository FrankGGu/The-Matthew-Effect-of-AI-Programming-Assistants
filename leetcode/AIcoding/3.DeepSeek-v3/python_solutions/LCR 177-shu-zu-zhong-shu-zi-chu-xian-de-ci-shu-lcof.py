class Solution:
    def colorTheArray(self, n: int, queries: List[List[int]]) -> List[int]:
        nums = [0] * n
        res = []
        count = 0
        for i, color in queries:
            left = nums[i - 1] if i > 0 else 0
            right = nums[i + 1] if i < n - 1 else 0
            if nums[i] != 0:
                if left == nums[i]:
                    count -= 1
                if right == nums[i]:
                    count -= 1
            nums[i] = color
            if left == color:
                count += 1
            if right == color:
                count += 1
            res.append(count)
        return res