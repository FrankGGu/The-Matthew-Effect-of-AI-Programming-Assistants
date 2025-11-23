class Solution:
    def findBeautifulIndices(self, s: str, a: str, b: str, k: int) -> list[int]:

        def compute_lps(pattern: str) -> list[int]:
            m = len(pattern)
            lps = [0] * m
            length = 0  # length of the previous longest prefix suffix
            i = 1
            while i < m:
                if pattern[i] == pattern[length]:
                    length += 1
                    lps[i] = length
                    i += 1
                else:
                    if length != 0:
                        length = lps[length - 1]
                    else:
                        lps[i] = 0
                        i += 1
            return lps

        def kmp_search(text: str, pattern: str) -> list[int]:
            n = len(text)
            m = len(pattern)
            if m == 0: 
                return list(range(n + 1)) 
            if n < m: 
                return []

            lps = compute_lps(pattern)
            indices = []
            i = 0  # index for text
            j = 0  # index for pattern
            while i < n:
                if pattern[j] == text[i]:
                    i += 1
                    j += 1

                if j == m:
                    indices.append(i - j)
                    j = lps[j - 1] 
                elif i < n and pattern[j] != text[i]:
                    if j != 0:
                        j = lps[j - 1]
                    else:
                        i += 1
            return indices

        indices_a = kmp_search(s, a)
        indices_b = kmp_search(s, b)

        beautiful_indices = []
        ptr_b = 0

        for i_a in indices_a:
            # Advance ptr_b to the first index in indices_b that is >= i_a - k
            while ptr_b < len(indices_b) and indices_b[ptr_b] < i_a - k:
                ptr_b += 1

            # Check if there is any index in indices_b within the range [i_a - k, i_a + k]
            # starting from ptr_b.
            # We use a temporary pointer to not disturb the main ptr_b for the next i_a.

            found_j = False
            temp_ptr_b = ptr_b
            while temp_ptr_b < len(indices_b) and indices_b[temp_ptr_b] <= i_a + k:
                found_j = True
                break

            if found_j:
                beautiful_indices.append(i_a)

        return beautiful_indices