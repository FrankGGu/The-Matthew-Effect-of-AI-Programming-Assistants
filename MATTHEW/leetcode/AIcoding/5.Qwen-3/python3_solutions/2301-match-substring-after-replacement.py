class Solution:
    def matchReplacement(self, s: str, t: str, replaceMap: dict) -> bool:
        n = len(t)
        for i in range(len(s) - n + 1):
            match = True
            for j in range(n):
                if s[i + j] != t[j] and replaceMap.get(t[j], '') != s[i + j]:
                    match = False
                    break
            if match:
                return True
        return False