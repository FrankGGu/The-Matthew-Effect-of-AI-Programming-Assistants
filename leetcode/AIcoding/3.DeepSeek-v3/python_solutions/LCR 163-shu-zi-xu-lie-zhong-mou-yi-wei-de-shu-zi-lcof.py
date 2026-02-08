class Solution:
    def findKthNumber(self, n: int, k: int) -> int:
        def countNumbers(prefix):
            count = 0
            next_prefix = prefix + 1
            while prefix <= n:
                count += min(n + 1, next_prefix) - prefix
                prefix *= 10
                next_prefix *= 10
            return count

        current = 1
        k -= 1
        while k > 0:
            count = countNumbers(current)
            if k >= count:
                current += 1
                k -= count
            else:
                current *= 10
                k -= 1
        return current