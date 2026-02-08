class Solution:
    def distinctEchoSubstrings(self, text: str) -> int:
        n = len(text)

        BASE = 31 # A prime number larger than 26 for lowercase English letters
        MOD1 = 10**9 + 7
        MOD2 = 10**9 + 9

        # Precompute powers of BASE for both moduli
        powers1 = [1] * (n + 1)
        powers2 = [1] * (n + 1)
        for i in range(1, n + 1):
            powers1[i] = (powers1[i-1] * BASE) % MOD1
            powers2[i] = (powers2[i-1] * BASE) % MOD2

        # Precompute prefix hashes for both moduli
        # prefix_hashes[k] stores hash of text[0:k]
        # (text[0] * BASE^(k-1) + text[1] * BASE^(k-2) + ... + text[k-1] * BASE^0) % MOD
        prefix_hashes1 = [0] * (n + 1)
        prefix_hashes2 = [0] * (n + 1)
        for i in range(n):
            # Map 'a' to 1, 'b' to 2, etc. This helps avoid 0 values and ensures positive hash contributions.
            val = ord(text[i]) - ord('a') + 1 
            prefix_hashes1[i+1] = (prefix_hashes1[i] * BASE + val) % MOD1
            prefix_hashes2[i+1] = (prefix_hashes2[i] * BASE + val) % MOD2

        # Helper function to get hash of substring text[start:end] (exclusive end)
        def get_hash(start, end, prefix_hashes, powers, MOD):
            # Formula: H(s[start:end]) = (H(s[0:end]) - H(s[0:start]) * BASE^(end-start)) % MOD
            # Ensure the result is positive by adding MOD and taking modulo again
            h = (prefix_hashes[end] - (prefix_hashes[start] * powers[end - start]) % MOD + MOD) % MOD
            return h

        distinct_echo_hashes = set()

        # Iterate through all possible starting positions 'i' for the first part 'a'
        for i in range(n):
            # Iterate through all possible half-lengths 'k' for 'a' and 'b'
            # 'k' must be at least 1 (non-empty parts)
            # The total length of the echo substring is 2*k
            # The end index of the echo substring is i + 2*k. This must be <= n.
            # So, 2*k <= n - i  =>  k <= (n - i) / 2
            for k in range(1, (n - i) // 2 + 1):
                start_a = i
                end_a = i + k # end_a is exclusive

                start_b = i + k
                end_b = i + 2*k # end_b is exclusive

                # Get hashes for the first part 'a'
                hash_a1 = get_hash(start_a, end_a, prefix_hashes1, powers1, MOD1)
                hash_a2 = get_hash(start_a, end_a, prefix_hashes2, powers2, MOD2)

                # Get hashes for the second part 'b'
                hash_b1 = get_hash(start_b, end_b, prefix_hashes1, powers1, MOD1)
                hash_b2 = get_hash(start_b, end_b, prefix_hashes2, powers2, MOD2)

                # If both hash pairs match, it's an echo substring
                if hash_a1 == hash_b1 and hash_a2 == hash_b2:
                    # Add the unique hash pair to the set to count distinct echo substrings
                    distinct_echo_hashes.add((hash_a1, hash_a2))

        return len(distinct_echo_hashes)