class Solution:
    def countRangeSum(self, nums: List[int], lower: int, upper: int) -> int:
        prefix = [0]
        for num in nums:
            prefix.append(prefix[-1] + num)

        def merge_sort(l, r):
            if l == r:
                return 0
            mid = (l + r) // 2
            count = merge_sort(l, mid) + merge_sort(mid + 1, r)

            i = j = mid + 1
            for left in prefix[l:mid + 1]:
                while i <= r and prefix[i] - left < lower:
                    i += 1
                while j <= r and prefix[j] - left <= upper:
                    j += 1
                count += j - i

            prefix[l:r + 1] = sorted(prefix[l:r + 1])
            return count

        return merge_sort(0, len(prefix) - 1)