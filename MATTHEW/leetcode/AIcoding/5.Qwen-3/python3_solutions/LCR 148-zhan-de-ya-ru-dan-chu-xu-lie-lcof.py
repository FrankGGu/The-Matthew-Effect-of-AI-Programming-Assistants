class Solution:
    def validateBookReturn(self, books: List[int], target: int) -> bool:
        stack = []
        i = 0
        for book in books:
            stack.append(book)
            while stack and stack[-1] == target:
                stack.pop()
                target += 1
        return not stack