class Solution:
    def getSubarrayBeauty(self, nums: List[int], k: int, x: int) -> List[int]:
        from collections import Counter

        n = len(nums)
        result = []
        count = Counter()

        for i in range(n):
            count[nums[i]] += 1
            if i >= k:
                count[nums[i - k]] -= 1
                if count[nums[i - k]] == 0:
                    del count[nums[i - k]]
            if i >= k - 1:
                beauty = 0
                for num in sorted(count):
                    if num < 0:
                        beauty += count[num]
                    else:
                        break
                if beauty < x:
                    result.append(0)
                else:
                    result.append(beauty)

        return result