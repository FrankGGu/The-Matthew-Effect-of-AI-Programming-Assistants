class Solution:
    def findBooks(self, books: List[Tuple[str, int]]) -> List[str]:
        return [title for title, copies in books if copies == 0]