class Solution:
    def *lastVisitedIntegers*(self, words: List[str]) -> List[int]:
        res = []
        temp = []
        for word in words:
            if word.isdigit():
                temp.append(int(word))
            else:
                res.extend(temp)
                temp = []
        res.extend(temp)
        return res