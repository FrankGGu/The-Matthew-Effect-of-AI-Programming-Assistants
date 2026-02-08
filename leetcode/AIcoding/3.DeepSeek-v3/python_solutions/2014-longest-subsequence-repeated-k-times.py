class Solution:
    def longestSubsequenceRepeatedK(self, s: str, k: int) -> str:
        freq = [0] * 26
        for c in s:
            freq[ord(c) - ord('a')] += 1

        chars = []
        for i in range(26):
            chars.extend([chr(ord('a') + i)] * (freq[i] // k))

        for l in range(len(chars), 0, -1):
            for candidate in itertools.permutations(chars, l):
                candidate = ''.join(candidate)
                pattern = re.compile('.*' + '.*'.join(candidate) + '.*')
                if pattern.match(s):
                    return candidate
        return ""