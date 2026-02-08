class Solution:
    def numSpecialEquivGroups(self, A: List[str]) -> int:
        def encode(s):
            even = [0] * 26
            odd = [0] * 26
            for i, char in enumerate(s):
                if i % 2 == 0:
                    even[ord(char) - ord('a')] += 1
                else:
                    odd[ord(char) - ord('a')] += 1
            return (tuple(even), tuple(odd))

        return len(set(encode(s) for s in A))