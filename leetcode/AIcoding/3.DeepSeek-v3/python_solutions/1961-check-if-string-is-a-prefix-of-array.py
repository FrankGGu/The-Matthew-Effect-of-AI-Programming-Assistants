class Solution:
    def isPrefixString(self, s: str, words: List[str]) -> bool:
        combined = ""
        for word in words:
            combined += word
            if combined == s:
                return True
            if len(combined) > len(s):
                return False
        return False