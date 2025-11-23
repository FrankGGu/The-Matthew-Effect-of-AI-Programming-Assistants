class Solution:
    def partition(self, s: str) -> List[List[str]]:
        def is_palindrome(sub):
            return sub == sub[::-1]

        def backtrack(start, path, result):
            if start == len(s):
                result.append(path[:])
                return

            for i in range(start, len(s)):
                sub = s[start:i+1]
                if is_palindrome(sub):
                    path.append(sub)
                    backtrack(i+1, path, result)
                    path.pop()

        result = []
        backtrack(0, [], result)
        return result