class Solution:
    def minOperations(self, nums: List[int], target: List[int]) -> int:
        from collections import defaultdict

        def get_freq(arr):
            freq = defaultdict(int)
            for num in arr:
                freq[num] += 1
            return freq

        def get_bit_counts(arr):
            counts = [0] * 32
            for num in arr:
                for i in range(32):
                    if num & (1 << i):
                        counts[i] += 1
            return counts

        def get_bit_counts_with_shifts(arr):
            counts = [0] * 32
            for num in arr:
                for i in range(32):
                    if num & (1 << i):
                        counts[i] += 1
            return counts

        def count_operations(target_counts, source_counts):
            operations = 0
            for i in range(32):
                if target_counts[i] > source_counts[i]:
                    operations += (target_counts[i] - source_counts[i]) * (1 << i)
                elif target_counts[i] < source_counts[i]:
                    operations += (source_counts[i] - target_counts[i]) * (1 << i)
            return operations

        target_counts = get_bit_counts(target)
        source_counts = get_bit_counts(nums)

        return count_operations(target_counts, source_counts)