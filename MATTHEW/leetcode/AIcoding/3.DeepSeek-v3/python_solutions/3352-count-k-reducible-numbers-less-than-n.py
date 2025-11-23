class Solution:
    def countKReducibleNumbers(self, n: int, k: int) -> int:
        if k == 0:
            return 0

        def is_k_reducible(num, k):
            while k > 0 and num >= 10:
                new_num = 0
                for digit in str(num):
                    new_num += int(digit)
                num = new_num
                k -= 1
            return num < 10 and k == 0

        count = 0
        for num in range(1, n):
            if is_k_reducible(num, k):
                count += 1
        return count