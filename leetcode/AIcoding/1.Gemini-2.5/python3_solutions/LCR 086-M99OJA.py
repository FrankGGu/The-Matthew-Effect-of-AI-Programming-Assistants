class Solution:
    def partition(self, s: str) -> List[List[str]]:
        result = []
        n = len(s)

        def is_palindrome(sub: str) -> bool:
            return sub == sub[::-1]

        def backtrack(start_index, current_partition):
            if start_index == n:
                result.append(list(current_partition))
                return

            for i in range(start_index, n):
                substring = s[start_index : i + 1]
                if is_palindrome(substring):
                    current_partition.append(substring)
                    backtrack(i + 1, current_partition)
                    current_partition.pop()

        backtrack(0, [])
        return result