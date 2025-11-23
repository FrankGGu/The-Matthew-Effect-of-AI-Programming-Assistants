import collections

class Solution:
    def maxPalindromesAfterOperations(self, words: List[str], queries: List[List[int]]) -> List[int]:
        n = len(words)

        prefix_char_counts = [[0] * 26 for _ in range(n + 1)]

        for i in range(n):
            for j in range(26):
                prefix_char_counts[i+1][j] = prefix_char_counts[i][j]

            for char_code_val in words[i]:
                prefix_char_counts[i+1][ord(char_code_val) - ord('a')] += 1

        results = []
        for l, r, k in queries:
            current_counts = [0] * 26
            for j in range(26):
                current_counts[j] = prefix_char_counts[r+1][j] - prefix_char_counts[l][j]

            total_pairs_from_chars = 0
            total_odd_chars = 0
            for count in current_counts:
                total_pairs_from_chars += count // 2
                total_odd_chars += count % 2

            effective_pairs = total_pairs_from_chars + total_odd_chars // 2
            effective_middle_chars = total_odd_chars % 2

            num_palindromes = 0

            num_pairs_per_palindrome = k // 2
            num_middle_chars_per_palindrome = k % 2

            if k == 1:
                num_palindromes = sum(current_counts)
            elif num_middle_chars_per_palindrome == 0: # k is even
                num_palindromes = effective_pairs // num_pairs_per_palindrome
            else: # k is odd, num_middle_chars_per_palindrome == 1
                if effective_middle_chars == 1:
                    if effective_pairs >= num_pairs_per_palindrome:
                        num_palindromes = 1
                        remaining_pairs = effective_pairs - num_pairs_per_palindrome
                        num_palindromes += remaining_pairs // (num_pairs_per_palindrome + 1)
                    else:
                        num_palindromes = 0
                else: # effective_middle_chars == 0
                    num_palindromes = effective_pairs // (num_pairs_per_palindrome + 1)

            results.append(num_palindromes)

        return results