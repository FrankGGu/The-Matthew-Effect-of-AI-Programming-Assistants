class Solution:
    def minAbsDifference(self, nums: List[int], goal: int) -> int:
        n = len(nums)
        first_half = nums[:n // 2]
        second_half = nums[n // 2:]

        def get_sums(arr):
            sums = []
            for i in range(1 << len(arr)):
                total = 0
                for j in range(len(arr)):
                    if i & (1 << j):
                        total += arr[j]
                sums.append(total)
            return sums

        first_sums = get_sums(first_half)
        second_sums = get_sums(second_half)
        second_sums.sort()

        closest = float('inf')
        for s in first_sums:
            target = goal - s
            lo, hi = 0, len(second_sums) - 1
            while lo <= hi:
                mid = (lo + hi) // 2
                if second_sums[mid] < target:
                    lo = mid + 1
                else:
                    hi = mid - 1

            if lo < len(second_sums):
                closest = min(closest, abs(s + second_sums[lo] - goal))
            if hi >= 0:
                closest = min(closest, abs(s + second_sums[hi] - goal))

        return closest