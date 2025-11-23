class Solution:
    def maximumSum(self, nums: List[int]) -> int:

        def get_digit_sum(n: int) -> int:
            s = 0
            while n > 0:
                s += n % 10
                n //= 10
            return s

        digit_sum_map = {}
        for num in nums:
            s = get_digit_sum(num)
            if s not in digit_sum_map:
                digit_sum_map[s] = []
            digit_sum_map[s].append(num)

        max_pair_sum = -1

        for s in digit_sum_map:
            numbers_with_same_digit_sum = digit_sum_map[s]
            if len(numbers_with_same_digit_sum) >= 2:
                numbers_with_same_digit_sum.sort(reverse=True)
                current_pair_sum = numbers_with_same_digit_sum[0] + numbers_with_same_digit_sum[1]
                if current_pair_sum > max_pair_sum:
                    max_pair_sum = current_pair_sum

        return max_pair_sum