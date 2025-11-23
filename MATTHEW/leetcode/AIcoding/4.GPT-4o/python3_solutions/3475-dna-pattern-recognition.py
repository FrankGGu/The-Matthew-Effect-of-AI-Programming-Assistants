class Solution:
    def findRepeatedDnaSequences(self, s: str) -> List[str]:
        seen, output = set(), set()
        for i in range(len(s) - 9):
            seq = s[i:i + 10]
            if seq in seen:
                output.add(seq)
            seen.add(seq)
        return list(output)