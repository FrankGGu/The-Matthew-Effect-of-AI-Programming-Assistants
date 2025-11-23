class Solution:
    def countExcellentPairs(self, nums: List[int], k: int) -> int:
        unique_nums = list(set(nums))
        bit_counts = []
        for num in unique_nums:
            bit_counts.append(bin(num).count('1'))

        bit_counts.sort()
        res = 0
        n = len(bit_counts)
        for i in range(n):
            left, right = 0, n - 1
            target = k - bit_counts[i]
            while left <= right:
                mid = (left + right) // 2
                if bit_counts[mid] >= target:
                    right = mid - 1
                else:
                    left = mid + 1
            res += n - left
        return res