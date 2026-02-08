class Solution:
    def longestDupSubstring(self, s: str) -> str:
        n = len(s)

        # Base and modulus for Rabin-Karp hashing
        # A prime base larger than the alphabet size is generally preferred.
        # For lowercase English letters, 26 is the alphabet size, so 31 is a good choice.
        base = 31

        # A large prime modulus to minimize collisions.
        # Using a Mersenne prime like 2^61 - 1 is common for 64-bit hashes.
        # Python handles arbitrary precision integers, so this works well.
        mod = (1 << 61) - 1 

        # Function to check if a duplicate substring of a given length L exists.
        # Returns the starting index of one such duplicate if found, otherwise -1.
        def check(L: int) -> int:
            if L == 0:
                return 0 # An empty string (length 0) is always a duplicate.

            # Precompute base^L % mod, which is used to remove the leading character's contribution.
            power_base_L = pow(base, L, mod)

            # Calculate the hash for the first substring s[0:L].
            current_hash = 0
            for i in range(L):
                # Convert character to a 1-indexed integer (a=1, b=2, ...)
                current_hash = (current_hash * base + (ord(s[i]) - ord('a') + 1)) % mod

            # Store hashes and their starting indices.
            # If a hash is encountered again, it indicates a potential duplicate.
            seen_hashes = {current_hash: 0} # {hash_value: start_index}

            # Iterate through the rest of the substrings using a rolling hash.
            for i in range(1, n - L + 1):
                # Remove the contribution of the character s[i-1] (the one leaving the window).
                current_hash = (current_hash - (ord(s[i-1]) - ord('a') + 1) * power_base_L) % mod

                # Add the contribution of the character s[i+L-1] (the one entering the window).
                current_hash = (current_hash * base + (ord(s[i+L-1]) - ord('a') + 1)) % mod

                # Ensure the hash remains non-negative (Python's % operator can return negative for negative inputs).
                current_hash = (current_hash + mod) % mod

                # If this hash has been seen before, we found a duplicate.
                if current_hash in seen_hashes:
                    # For full robustness, one might compare the actual strings to handle hash collisions.
                    # However, with a good base and large prime modulus, this is often not necessary for LeetCode.
                    # if s[seen_hashes[current_hash]:seen_hashes[current_hash]+L] == s[i:i+L]:
                    return i # Return the starting index of the current duplicate.

                # Store the current hash and its starting index.
                seen_hashes[current_hash] = i

            return -1 # No duplicate of length L found.

        # Binary search for the longest possible duplicate substring length.
        # The length can range from 0 to n-1 (e.g., for "aaaaa", the longest duplicate is "aaaa", length 4).
        low = 0
        high = n - 1 

        longest_dup_start_idx = 0 # Stores the start index of the longest duplicate found.
        longest_dup_length = 0    # Stores the length of the longest duplicate found.

        while low <= high:
            mid = low + (high - low) // 2

            # Try to find a duplicate substring of length 'mid'.
            start_idx = check(mid)

            if start_idx != -1:
                # If a duplicate of length 'mid' is found, it means we can potentially find an even longer one.
                longest_dup_length = mid
                longest_dup_start_idx = start_idx
                low = mid + 1 # Try searching in the upper half.
            else:
                # If no duplicate of length 'mid' is found, we need to search for a shorter one.
                high = mid - 1 # Try searching in the lower half.

        # Return the longest duplicate substring found.
        return s[longest_dup_start_idx : longest_dup_start_idx + longest_dup_length]