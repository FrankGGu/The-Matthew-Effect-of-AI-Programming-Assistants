class Solution:
    def countBeautifulPairs(self, nums: List[int]) -> int:
        from collections import defaultdict

        count = 0
        freq = defaultdict(int)

        for num in nums:
            first_digit = int(str(num)[0])
            last_digit = num % 10
            if first_digit == last_digit:
                count += 1
            freq[(first_digit, last_digit)] += 1

        for (f, l), c in freq.items():
            if f != l:
                count += c * freq[(l, f)]

        return count