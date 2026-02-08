class Solution:
    def minimumDifference(self, nums: List[int]) -> int:
        n = len(nums)
        half = n // 2
        total_sum = sum(nums)

        left_sums = defaultdict(list)
        for i in range(half + 1):
            for comb in combinations(nums[:half], i):
                left_sums[i].append(sum(comb))

        right_sums = defaultdict(list)
        for i in range(n - half + 1):
            for comb in combinations(nums[half:], i):
                right_sums[i].append(sum(comb))

        for i in range(half + 1):
            left_sums[i].sort()

        result = float('inf')
        for i in range(half + 1):
            for left in left_sums[i]:
                target = (total_sum - left) / 2
                low, high = 0, len(right_sums[half - i]) - 1

                while low <= high:
                    mid = (low + high) // 2
                    if right_sums[half - i][mid] < target:
                        low = mid + 1
                    else:
                        high = mid - 1

                if low < len(right_sums[half - i]):
                    result = min(result, abs(total_sum - 2 * (left + right_sums[half - i][low])))
                if high >= 0:
                    result = min(result, abs(total_sum - 2 * (left + right_sums[half - i][high])))

        return result