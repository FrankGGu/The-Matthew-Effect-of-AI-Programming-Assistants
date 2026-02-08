class Solution:
    def minOperations(self, books: List[int]) -> int:
        count = 0
        for book in books:
            if book > 0:
                count += 1
        return count