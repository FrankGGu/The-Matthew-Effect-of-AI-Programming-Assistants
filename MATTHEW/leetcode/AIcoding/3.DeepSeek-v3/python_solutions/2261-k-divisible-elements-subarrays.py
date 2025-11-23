class Solution:
    def countDistinct(self, nums: List[int], k: int, p: int) -> int:
        n = len(nums)
        res = set()
        for i in range(n):
            count = 0
            current_subarray = []
            for j in range(i, n):
                if nums[j] % p == 0:
                    count += 1
                if count > k:
                    break
                current_subarray.append(nums[j])
                res.add(tuple(current_subarray))
        return len(res)