class Solution:
    def countRangeSum(self, nums: List[int], lower: int, upper: int) -> int:
        prefix_sum = [0]
        for num in nums:
            prefix_sum.append(prefix_sum[-1] + num)

        def merge_count(start, end):
            if start >= end:
                return 0
            mid = (start + end) // 2
            count = merge_count(start, mid) + merge_count(mid + 1, end)
            j = k = mid + 1

            for i in range(start, mid + 1):
                while j <= end and prefix_sum[j] - prefix_sum[i] < lower:
                    j += 1
                while k <= end and prefix_sum[k] - prefix_sum[i] <= upper:
                    k += 1
                count += k - j

            prefix_sum[start:end + 1] = sorted(prefix_sum[start:end + 1])
            return count

        return merge_count(0, len(prefix_sum) - 1)