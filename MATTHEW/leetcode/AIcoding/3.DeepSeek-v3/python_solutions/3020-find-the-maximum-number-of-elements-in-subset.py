class Solution:
    def maximumLength(self, nums: List[int]) -> int:
        from collections import defaultdict

        freq = defaultdict(int)
        for num in nums:
            freq[num] += 1

        max_len = 1

        for num in sorted(freq.keys(), reverse=True):
            current = num
            length = 0
            while current in freq and freq[current] > 0:
                if current == 1:
                    if freq[current] % 2 == 1:
                        length += freq[current]
                    else:
                        length += freq[current] - 1
                    break
                if freq[current] >= 2:
                    length += 2
                    freq[current] -= 2
                    current = current * current
                else:
                    break
            if length % 2 == 0:
                length -= 1
            max_len = max(max_len, length)

        return max_len