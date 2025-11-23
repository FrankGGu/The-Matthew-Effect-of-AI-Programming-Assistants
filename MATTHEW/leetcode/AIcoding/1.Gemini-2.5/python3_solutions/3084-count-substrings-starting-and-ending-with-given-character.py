class Solution:
    def countSubstrings(self, s: str, c: str) -> int:
        count = 0
        for char_s in s:
            if char_s == c:
                count += 1

        # If there are 'k' occurrences of character 'c',
        # any pair of these occurrences (start_index, end_index)
        # where start_index <= end_index forms a valid substring.
        # This is equivalent to choosing 2 indices from 'k' with replacement
        # and order not mattering, or simply the sum of numbers from 1 to k.
        # Sum of 1 to k is k * (k + 1) / 2.
        return count * (count + 1) // 2