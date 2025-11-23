class Solution:
    def makeLargestSpecial(self, s: str) -> str:
        if not s:
            return ""

        balance = 0
        start = 0
        sub_strings = []

        for i in range(len(s)):
            if s[i] == '1':
                balance += 1
            else:
                balance -= 1

            if balance == 0:
                sub_strings.append('1' + self.makeLargestSpecial(s[start+1:i]) + '0')
                start = i + 1

        sub_strings.sort(reverse=True)

        return "".join(sub_strings)