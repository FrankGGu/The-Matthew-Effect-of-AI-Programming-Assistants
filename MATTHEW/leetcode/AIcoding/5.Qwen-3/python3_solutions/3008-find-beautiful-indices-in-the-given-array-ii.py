class Solution:
    def beautifulIndices(self, nums: str, s: str, k: int) -> List[int]:
        from collections import defaultdict

        def build_kmp_failure_function(pattern):
            n = len(pattern)
            fail = [0] * n
            j = 0
            for i in range(1, n):
                while j > 0 and pattern[i] != pattern[j]:
                    j = fail[j - 1]
                if pattern[i] == pattern[j]:
                    j += 1
                    fail[i] = j
                else:
                    fail[i] = 0
            return fail

        def kmp_search(text, pattern, fail):
            j = 0
            indices = []
            for i in range(len(text)):
                while j > 0 and text[i] != pattern[j]:
                    j = fail[j - 1]
                if text[i] == pattern[j]:
                    j += 1
                if j == len(pattern):
                    indices.append(i - len(pattern) + 1)
                    j = fail[j - 1]
            return indices

        pos = defaultdict(list)
        for i in range(len(s)):
            pos[s[i]].append(i)

        result = []
        for i in range(len(nums)):
            found = False
            for c in pos:
                if c == nums[i]:
                    for j in pos[c]:
                        if abs(j - i) <= k:
                            found = True
                            break
                    if found:
                        break
            if found:
                result.append(i)
        return result