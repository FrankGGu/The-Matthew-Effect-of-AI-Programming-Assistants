import collections

class Solution:
    def countPrefixSuffixPairs(self, words: list[str]) -> int:
        P1 = 31
        M1 = 1_000_000_007
        P2 = 37
        M2 = 1_000_000_009

        MAX_WORD_LEN = 101  # Max word length is 100, so we need powers up to 100.

        # Precompute powers for hashing
        # pow1[k] stores P1^k % M1
        # pow2[k] stores P2^k % M2
        pow1 = [1] * MAX_WORD_LEN
        pow2 = [1] * MAX_WORD_LEN

        for i in range(1, MAX_WORD_LEN):
            pow1[i] = (pow1[i-1] * P1) % M1
            pow2[i] = (pow2[i-1] * P2) % M2

        # Stores counts of (hash1, hash2) tuples for words encountered so far.
        # A hash tuple uniquely (with high probability) represents a word.
        word_hash_counts = collections.defaultdict(int)

        total_pairs = 0

        for word in words:
            n = len(word)

            # Precompute prefix hashes for the current word.
            # pref_h1[k] stores hash of word[0...k-1] (length k)
            pref_h1 = [0] * (n + 1)
            pref_h2 = [0] * (n + 1)

            for i in range(n):
                char_val = ord(word[i]) - ord('a') + 1
                pref_h1[i+1] = (pref_h1[i] * P1 + char_val) % M1
                pref_h2[i+1] = (pref_h2[i] * P2 + char_val) % M2

            # Helper function to get hash of a substring word[start_idx...end_idx]
            # h_array: prefix hash array (pref_h1 or pref_h2)
            # power_array: precomputed powers array (pow1 or pow2)
            # M: modulus (M1 or M2)
            def get_substring_hash(h_array, power_array, start_idx, end_idx, M):
                length = end_idx - start_idx + 1
                # Hash(S[start:end+1]) = (Hash(S[0:end+1]) - Hash(S[0:start]) * P^length) % M
                res = (h_array[end_idx+1] - (h_array[start_idx] * power_array[length]) % M + M) % M
                return res

            # Iterate through all possible lengths 'l' (from 1 to n) for a prefix-suffix.
            for l in range(1, n + 1):
                # Calculate hash of the prefix: word[0...l-1]
                prefix_hash1 = get_substring_hash(pref_h1, pow1, 0, l-1, M1)
                prefix_hash2 = get_substring_hash(pref_h2, pow2, 0, l-1, M2)

                # Calculate hash of the suffix: word[n-l...n-1]
                suffix_hash1 = get_substring_hash(pref_h1, pow1, n-l, n-1, M1)
                suffix_hash2 = get_substring_hash(pref_h2, pow2, n-l, n-1, M2)

                # If both hash pairs match, the prefix and suffix are (likely) the same string.
                if prefix_hash1 == suffix_hash1 and prefix_hash2 == suffix_hash2:
                    # This (prefix_hash1, prefix_hash2) tuple represents a string that is
                    # both a prefix and a suffix of the current 'word'.
                    # Add the count of how many times this string (represented by its hash)
                    # has been encountered as a full word before (i.e., words[i] where i < current_index).
                    total_pairs += word_hash_counts[(prefix_hash1, prefix_hash2)]

            # After checking all prefix-suffixes for the current word,
            # add the current word's hash to the counts.
            # The hash of the full word is stored in pref_h1[n] and pref_h2[n].
            word_hash_counts[(pref_h1[n], pref_h2[n])] += 1

        return total_pairs