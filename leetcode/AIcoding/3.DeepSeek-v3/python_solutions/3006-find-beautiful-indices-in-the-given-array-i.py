class Solution:
    def beautifulIndices(self, s: str, a: str, b: str, k: int) -> List[int]:
        def compute_lps(pattern):
            lps = [0] * len(pattern)
            length = 0
            i = 1
            while i < len(pattern):
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

        def kmp_search(text, pattern):
            if not pattern:
                return []
            lps = compute_lps(pattern)
            i = j = 0
            res = []
            while i < len(text):
                if text[i] == pattern[j]:
                    i += 1
                    j += 1
                    if j == len(pattern):
                        res.append(i - j)
                        j = lps[j - 1]
                else:
                    if j != 0:
                        j = lps[j - 1]
                    else:
                        i += 1
            return res

        a_indices = kmp_search(s, a)
        b_indices = kmp_search(s, b)
        beautiful = []
        if not a_indices or not b_indices:
            return beautiful

        ptr_b = 0
        len_b = len(b_indices)
        for i in a_indices:
            while ptr_b < len_b and b_indices[ptr_b] < i - k:
                ptr_b += 1
            if ptr_b < len_b and abs(b_indices[ptr_b] - i) <= k:
                beautiful.append(i)
        return beautiful