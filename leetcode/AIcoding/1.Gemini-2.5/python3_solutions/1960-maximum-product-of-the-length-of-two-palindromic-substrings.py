class Solution:
    def maxProduct(self, s: str) -> int:
        n = len(s)
        if n < 2:
            return 0

        is_palindrome = [[False] * n for _ in range(n)]

        # Fill is_palindrome table
        # Palindromes of length 1
        for i in range(n):
            is_palindrome[i][i] = True

        # Palindromes of length 2
        for i in range(n - 1):
            if s[i] == s[i+1]:
                is_palindrome[i][i+1] = True

        # Palindromes of length 3 or more
        for length in range(3, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                if s[i] == s[j] and is_palindrome[i+1][j-1]:
                    is_palindrome[i][j] = True

        max_pal_len_in_prefix = [0] * n
        max_pal_len_in_suffix = [0] * n

        # Populate max_pal_len_in_prefix
        # max_pal_len_in_prefix[k] stores the maximum length of any palindrome s[i...j] where j <= k
        current_max_len = 0
        for j in range(n):
            for i in range(j + 1):
                if is_palindrome[i][j]:
                    current_max_len = max(current_max_len, j - i + 1)
            max_pal_len_in_prefix[j] = current_max_len

        # Populate max_pal_len_in_suffix
        # max_pal_len_in_suffix[k] stores the maximum length of any palindrome s[i...j] where i >= k
        current_max_len = 0
        for i in range(n - 1, -1, -1):
            for j in range(n - 1, i - 1, -1):
                if is_palindrome[i][j]:
                    current_max_len = max(current_max_len, j - i + 1)
            max_pal_len_in_suffix[i] = current_max_len

        max_product = 0

        # Iterate through all possible split points k
        # The first palindrome is entirely within s[0...k]
        # The second palindrome is entirely within s[k+1...n-1]
        for k in range(n - 1):
            left_part_max_len = max_pal_len_in_prefix[k]
            right_part_max_len = max_pal_len_in_suffix[k+1]
            max_product = max(max_product, left_part_max_len * right_part_max_len)

        return max_product