class Solution:
    def subStrHash(self, s: str, power: int, modulo: int, k: int, hashValue: int) -> str:
        n = len(s)

        # Calculate power^(k-1) % modulo, which is used to remove the highest power term
        p_pow_k_minus_1 = 1
        for _ in range(k - 1):
            p_pow_k_minus_1 = (p_pow_k_minus_1 * power) % modulo

        current_hash = 0
        ans_idx = -1

        # Calculate the hash for the rightmost substring of length k (s[n-k ... n-1])
        # This will be our starting point for rolling the hash backwards.
        # The hash function is (sub[0] * power^0 + sub[1] * power^1 + ... + sub[k-1] * power^(k-1)) % modulo
        p_factor = 1
        for j in range(n - k, n):
            char_val = ord(s[j]) - ord('a') + 1
            current_hash = (current_hash + char_val * p_factor) % modulo
            p_factor = (p_factor * power) % modulo

        # If the hash of the rightmost substring matches hashValue, store its starting index
        if current_hash == hashValue:
            ans_idx = n - k

        # Roll the hash backwards from s[n-k-1 ... n-2] down to s[0 ... k-1]
        # In each step, 'current_hash' holds the hash for s[i+1 ... i+k]
        # We want to compute the hash for s[i ... i+k-1]
        for i in range(n - k - 1, -1, -1):
            # 1. Remove the contribution of the character s[i+k] from the previous window s[i+1 ... i+k].
            #    In that window, s[i+k] was the (k-1)-th character (0-indexed), so its term was val(s[i+k]) * power^(k-1).
            val_to_remove = ord(s[i+k]) - ord('a') + 1
            term_to_remove = (val_to_remove * p_pow_k_minus_1) % modulo
            current_hash = (current_hash - term_to_remove + modulo) % modulo

            # 2. Multiply by 'power' to shift the powers of the remaining characters.
            #    After removing val(s[i+k])*power^(k-1), current_hash is (val(s[i+1])*power^0 + ... + val(s[i+k-1])*power^(k-2)).
            #    Multiplying by 'power' makes it (val(s[i+1])*power^1 + ... + val(s[i+k-1])*power^(k-1)).
            current_hash = (current_hash * power) % modulo

            # 3. Add the contribution of the new leftmost character s[i].
            #    In the current window s[i ... i+k-1], s[i] is the 0-th character, so its term is val(s[i]) * power^0.
            val_to_add = ord(s[i]) - ord('a') + 1
            current_hash = (current_hash + val_to_add) % modulo

            # If the current hash matches hashValue, update ans_idx.
            # Since we are iterating backwards, the last match found will be the leftmost (first) one.
            if current_hash == hashValue:
                ans_idx = i

        # Return the substring starting at ans_idx with length k
        return s[ans_idx : ans_idx + k]