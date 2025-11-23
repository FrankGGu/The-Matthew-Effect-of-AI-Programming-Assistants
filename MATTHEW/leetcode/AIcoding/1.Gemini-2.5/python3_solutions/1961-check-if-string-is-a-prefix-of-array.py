class Solution:
    def isPrefixString(self, s: str, words: list[str]) -> bool:
        current_prefix = ""
        for word in words:
            current_prefix += word
            if current_prefix == s:
                return True
            if len(current_prefix) >= len(s):
                return False
        return False