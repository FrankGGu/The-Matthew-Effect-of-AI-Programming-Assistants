class Solution:
    def minimumSum(self, num: int) -> int:
        def is_valid(n):
            return n % 10 == num % 10

        def find_min_sum(k):
            res = 0
            count = 0
            i = 0
            while count < k:
                if i % 10 == num % 10:
                    res += i
                    count += 1
                i += 1
            return res

        return find_min_sum(num)