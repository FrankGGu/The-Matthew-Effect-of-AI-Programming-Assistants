class Solution:
    def makeLargestSpecial(self, s: str) -> str:
        if not s:
            return ""

        count = 0
        start = 0
        result = []

        for i, c in enumerate(s):
            if c == '1':
                count += 1
            else:
                count -= 1

            if count == 0:
                result.append('1' + self.makeLargestSpecial(s[start+1:i]) + '0')
                start = i + 1

        result.sort(reverse=True)
        return "".join(result)