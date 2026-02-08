class Solution:
    def minCharacters(self, a: str, b: str) -> int:
        def count_operations(a, b):
            res = float('inf')
            count_a = [0] * 26
            count_b = [0] * 26
            for c in a:
                count_a[ord(c) - ord('a')] += 1
            for c in b:
                count_b[ord(c) - ord('a')] += 1

            # Condition 3: all in a and b are same character
            total_chars = len(a) + len(b)
            for i in range(26):
                res = min(res, total_chars - (count_a[i] + count_b[i]))

            # Condition 1: a < b
            prefix_a = 0
            prefix_b = 0
            for i in range(25):
                prefix_a += count_a[i]
                prefix_b += count_b[i]
                res = min(res, (len(a) - prefix_a) + prefix_b)

            # Condition 2: b < a
            prefix_a = 0
            prefix_b = 0
            for i in range(25):
                prefix_a += count_a[i]
                prefix_b += count_b[i]
                res = min(res, (len(b) - prefix_b) + prefix_a)

            return res

        return min(count_operations(a, b), count_operations(b, a))