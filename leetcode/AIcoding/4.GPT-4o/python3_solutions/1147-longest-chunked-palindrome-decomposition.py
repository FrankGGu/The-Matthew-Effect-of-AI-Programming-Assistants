class Solution:
    def longestDecomposition(self, text: str) -> int:
        n = len(text)
        count = 0
        left, right = 0, n - 1

        while left <= right:
            if text[left] == text[right]:
                left += 1
                right -= 1
            else:
                count += 1
                left += 1
                right = n - 1

            if left > right:
                count += 1

        return count