class Solution:
    def minimumLengthEncoding(self, words: List[str]) -> int:
        words = sorted(set(words), key=lambda x: -len(x))
        encoding = ""
        for word in words:
            if not any(word.endswith(other) for other in encoding.split('#')):
                encoding += word + '#'
        return len(encoding)