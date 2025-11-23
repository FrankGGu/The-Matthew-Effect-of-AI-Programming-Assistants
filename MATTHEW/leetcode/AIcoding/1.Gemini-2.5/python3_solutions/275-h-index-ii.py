class Solution:
    def hIndex(self, citations: list[int]) -> int:
        n = len(citations)
        low = 0
        high = n - 1
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2

            # The number of papers with at least citations[mid] citations is (n - mid).
            # If citations[mid] is greater than or equal to (n - mid),
            # it means we have found (n - mid) papers that each have at least (n - mid) citations.
            # So, (n - mid) is a possible h-index. We try to find a larger h-index
            # by looking at the left half (smaller mid, which means larger n - mid).
            if citations[mid] >= (n - mid):
                ans = n - mid
                high = mid - 1
            # If citations[mid] is less than (n - mid),
            # it means citations[mid] is too small for (n - mid) to be the h-index.
            # We need a smaller h-index, which means looking at the right half
            # (larger mid, which means smaller n - mid).
            else:
                low = mid + 1

        return ans