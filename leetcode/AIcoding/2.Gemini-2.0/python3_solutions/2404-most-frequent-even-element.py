class Solution:
    def mostFrequentEven(self, nums: list[int]) -> int:
        counts = {}
        for num in nums:
            if num % 2 == 0:
                counts[num] = counts.get(num, 0) + 1

        if not counts:
            return -1

        max_freq = 0
        most_frequent = -1

        for num, freq in counts.items():
            if freq > max_freq:
                max_freq = freq
                most_frequent = num
            elif freq == max_freq and num < most_frequent:
                most_frequent = num

        return most_frequent