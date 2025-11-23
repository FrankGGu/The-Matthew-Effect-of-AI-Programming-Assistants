class Solution:
    def findRepeatedDnaSequences(self, s: str) -> List[str]:
        seen = set()
        repeated = set()
        n = len(s)
        for i in range(n - 9):
            substring = s[i:i+10]
            if substring in seen:
                repeated.add(substring)
            seen.add(substring)
        return list(repeated)