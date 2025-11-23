from collections import defaultdict

class Solution:
    def mostFrequent(self, nums: List[int], key: int) -> int:
        counts = defaultdict(int)
        for i in range(len(nums) - 1):
            if nums[i] == key:
                counts[nums[i+1]] += 1

        max_count = 0
        most_frequent = -1

        for num, count in counts.items():
            if count > max_count:
                max_count = count
                most_frequent = num

        return most_frequent