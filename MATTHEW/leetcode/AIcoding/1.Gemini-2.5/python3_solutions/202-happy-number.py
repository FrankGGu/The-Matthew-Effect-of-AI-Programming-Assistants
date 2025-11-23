class Solution:
    def isHappy(self, n: int) -> bool:
        def get_next(num: int) -> int:
            total_sum = 0
            while num > 0:
                digit = num % 10
                total_sum += digit * digit
                num //= 10
            return total_sum

        seen = set()
        current_num = n
        while current_num != 1 and current_num not in seen:
            seen.add(current_num)
            current_num = get_next(current_num)

        return current_num == 1