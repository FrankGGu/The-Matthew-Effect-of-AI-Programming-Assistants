class Solution:
    def minSwaps(self, data: List[int], k: int) -> int:
        ones = sum(data)
        if ones == 0 or ones == k:
            return 0

        curr_ones = sum(data[:k])
        max_ones = curr_ones

        for i in range(k, len(data)):
            curr_ones += data[i] - data[i - k]
            max_ones = max(max_ones, curr_ones)

        return k - max_ones