class Solution:
    def kMirror(self, k: int, n: int) -> int:
        def is_palindrome(x: str) -> bool:
            return x == x[::-1]

        def to_base(num: int, base: int) -> str:
            if num == 0:
                return "0"
            digits = []
            while num:
                digits.append(int(num % base))
                num //= base
            return ''.join(str(x) for x in digits[::-1])

        count, total_sum = 0, 0
        num = 1
        while count < n:
            if is_palindrome(str(num)):
                base_k = to_base(num, k)
                if is_palindrome(base_k):
                    total_sum += num
                    count += 1
            num += 1
        return total_sum