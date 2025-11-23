class Solution:
    def longestDecomposition(self, text: str) -> int:
        n = len(text)
        count = 0
        left = 0
        right = n - 1

        P = 31
        M = 10**9 + 7

        powers = [1] * (n + 1)
        for i in range(1, n + 1):
            powers[i] = (powers[i-1] * P) % M

        prefix_hashes = [0] * (n + 1)
        for i in range(1, n + 1):
            prefix_hashes[i] = (prefix_hashes[i-1] * P + (ord(text[i-1]) - ord('a') + 1)) % M

        def get_substring_hash(start, end):
            length = end - start + 1
            hash_val = (prefix_hashes[end+1] - (prefix_hashes[start] * powers[length]) % M + M) % M
            return hash_val

        while left <= right:
            found_match = False
            for length in range((right - left + 1) // 2, 0, -1):
                hash_prefix = get_substring_hash(left, left + length - 1)
                hash_suffix = get_substring_hash(right - length + 1, right)

                if hash_prefix == hash_suffix:
                    if text[left : left + length] == text[right - length + 1 : right + 1]:
                        count += 2
                        left += length
                        right -= length
                        found_match = True
                        break

            if not found_match:
                count += 1
                break

        return count