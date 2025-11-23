class Solution:
    def findRepeatedDnaSequences(self, s: str) -> List[str]:
        seen = set()
        result = set()
        for i in range(len(s) - 9):
            seq = s[i:i+10]
            if seq in seen:
                result.add(seq)
            else:
                seen.add(seq)
        return list(result)