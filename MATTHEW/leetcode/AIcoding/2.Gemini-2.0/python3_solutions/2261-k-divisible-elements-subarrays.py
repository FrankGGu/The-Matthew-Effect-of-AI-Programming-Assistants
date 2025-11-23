class Solution:
    def countDistinct(self, nums: List[int], k: int, p: int) -> int:
        s = set()
        for i in range(len(nums)):
            count = 0
            sub = []
            for j in range(i, len(nums)):
                if nums[j] % p == 0:
                    count += 1
                if count > k:
                    break
                sub.append(nums[j])
                s.add(tuple(sub))
        return len(s)