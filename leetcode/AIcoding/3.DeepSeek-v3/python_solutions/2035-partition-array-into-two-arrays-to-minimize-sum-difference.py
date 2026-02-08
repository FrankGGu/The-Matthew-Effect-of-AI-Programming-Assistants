class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        n = len(nums)
        total = sum(nums)
        half = total // 2
        m = n // 2

        left = nums[:m]
        right = nums[m:]

        left_sums = [[] for _ in range(m + 1)]
        right_sums = [[] for _ in range(m + 1)]

        for mask in range(1 << m):
            cnt = bin(mask).count('1')
            s = 0
            for i in range(m):
                if mask & (1 << i):
                    s += left[i]
            left_sums[cnt].append(s)

        for mask in range(1 << m):
            cnt = bin(mask).count('1')
            s = 0
            for i in range(m):
                if mask & (1 << i):
                    s += right[i]
            right_sums[cnt].append(s)

        for k in range(m + 1):
            right_sums[k].sort()

        min_diff = float('inf')

        for k in range(m + 1):
            lk = k
            rk = m - k
            if not left_sums[lk] or not right_sums[rk]:
                continue
            for s in left_sums[lk]:
                target = half - s
                arr = right_sums[rk]
                idx = bisect.bisect_left(arr, target)
                for i in [idx - 1, idx]:
                    if 0 <= i < len(arr):
                        sum1 = s + arr[i]
                        sum2 = total - sum1
                        diff = abs(sum1 - sum2)
                        if diff < min_diff:
                            min_diff = diff
                            if min_diff == 0:
                                return 0
        return min_diff