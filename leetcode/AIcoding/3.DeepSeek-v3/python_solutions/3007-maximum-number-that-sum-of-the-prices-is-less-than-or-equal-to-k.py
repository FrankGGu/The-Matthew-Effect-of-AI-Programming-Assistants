class Solution:
    def findMaximumNumber(self, k: int, x: int) -> int:
        def count_set_bits(num):
            res = 0
            for i in range(1, 61):
                if i % x != 0:
                    continue
                div = 1 << i
                full_cycles = num // div
                res += full_cycles * (div // 2)
                remainder = num % div
                res += max(0, remainder - (div // 2) + 1)
            return res

        left = 1
        right = 1 << 60
        answer = 0
        while left <= right:
            mid = (left + right) // 2
            total = count_set_bits(mid)
            if total <= k:
                answer = mid
                left = mid + 1
            else:
                right = mid - 1
        return answer