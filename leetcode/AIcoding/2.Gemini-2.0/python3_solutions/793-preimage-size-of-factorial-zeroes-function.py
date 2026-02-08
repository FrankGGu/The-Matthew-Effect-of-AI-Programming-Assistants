class Solution:
    def preimageSizeFZF(self, k: int) -> int:
        def count_trailing_zeros(n):
            count = 0
            i = 5
            while n // i >= 1:
                count += n // i
                i *= 5
            return count

        def find_smallest_n(k):
            low = 0
            high = 5 * k
            while low <= high:
                mid = (low + high) // 2
                zeros = count_trailing_zeros(mid)
                if zeros < k:
                    low = mid + 1
                else:
                    high = mid - 1
            return low

        return find_smallest_n(k + 1) - find_smallest_n(k)