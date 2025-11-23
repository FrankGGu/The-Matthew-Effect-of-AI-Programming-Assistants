class Solution:
    def getSubarrayBeauty(self, nums: List[int], k: int, x: int) -> List[int]:
        from collections import defaultdict

        result = []
        freq = defaultdict(int)
        for i in range(len(nums)):
            if nums[i] < 0:
                freq[nums[i]] += 1
            if i >= k:
                if nums[i - k] < 0:
                    freq[nums[i - k]] -= 1
                    if freq[nums[i - k]] == 0:
                        del freq[nums[i - k]]
            if i >= k - 1:
                count = 0
                beauty = 0
                for num in sorted(freq.keys()):
                    count += freq[num]
                    if count >= x:
                        beauty = num
                        break
                result.append(beauty)
        return result