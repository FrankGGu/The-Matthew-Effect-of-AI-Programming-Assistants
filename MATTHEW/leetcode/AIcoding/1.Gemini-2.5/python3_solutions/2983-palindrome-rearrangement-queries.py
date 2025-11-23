class Solution:
    def canMakePalindromeRearrangementQueries(self, s: str, queries: list[list[int]]) -> list[bool]:
        n = len(s)

        prefix_counts = [[0] * 26 for _ in range(n + 1)]

        for i in range(n):
            for j in range(26):
                prefix_counts[i+1][j] = prefix_counts[i][j]
            char_idx = ord(s[i]) - ord('a')
            prefix_counts[i+1][char_idx] += 1

        results = []
        for l1, r1, l2, r2, k in queries:

            def get_counts(l, r):
                counts = [0] * 26
                for j in range(26):
                    counts[j] = prefix_counts[r+1][j] - prefix_counts[l][j]
                return counts

            def can_form_palindrome(counts):
                odd_freq_count = 0
                for count in counts:
                    if count % 2 == 1:
                        odd_freq_count += 1
                return odd_freq_count <= 1

            counts1 = get_counts(l1, r1)
            counts2 = get_counts(l2, r2)

            can_pali1 = can_form_palindrome(counts1)
            can_pali2 = can_form_palindrome(counts2)

            if not (can_pali1 and can_pali2):
                results.append(False)
                continue

            diff_ops = 0
            for j in range(26):
                diff_ops += abs(counts1[j] - counts2[j])

            if diff_ops // 2 <= k:
                results.append(True)
            else:
                results.append(False)

        return results