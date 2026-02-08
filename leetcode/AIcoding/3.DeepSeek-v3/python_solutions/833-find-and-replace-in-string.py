class Solution:
    def findReplaceString(self, s: str, indices: List[int], sources: List[str], targets: List[str]) -> str:
        res = list(s)
        for i, src, tgt in sorted(zip(indices, sources, targets), key=lambda x: -x[0]):
            if s.startswith(src, i):
                res[i:i+len(src)] = list(tgt)
        return ''.join(res)