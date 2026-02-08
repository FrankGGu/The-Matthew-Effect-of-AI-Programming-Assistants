class Solution:
    def colorTheArray(self, n: int, queries: List[List[int]]) -> List[int]:
        nums = [0] * n
        res = []
        count = 0
        for idx, color in queries:
            left = idx - 1
            right = idx + 1
            if nums[idx] != 0:
                if left >= 0 and nums[left] == nums[idx]:
                    count -= 1
                if right < n and nums[right] == nums[idx]:
                    count -= 1
            nums[idx] = color
            if left >= 0 and nums[left] == nums[idx]:
                count += 1
            if right < n and nums[right] == nums[idx]:
                count += 1
            res.append(count)
        return res