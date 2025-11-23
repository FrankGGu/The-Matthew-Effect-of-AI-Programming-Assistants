class Solution:
    def minSwaps(self, data: List[int]) -> int:
        ones = sum(data)
        if ones == 0 or ones == len(data):
            return 0

        n = len(data)
        data += data
        max_ones = 0
        current_ones = sum(data[:ones])

        for i in range(ones, len(data)):
            current_ones += data[i] - data[i - ones]
            max_ones = max(max_ones, current_ones)

        return ones - max_ones