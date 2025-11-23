class Solution:
    def isAcronym(self, words: list[str], s: str) -> bool:
        acronym = ""
        for word in words:
            acronym += word[0]
        return acronym == s