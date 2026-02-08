class Solution:
    def makeLargestSpecial(self, S: str) -> str:
        count = i = 0
        specials = []

        for j in range(len(S)):
            count += 1 if S[j] == '1' else -1
            if count == 0:
                specials.append('1' + self.makeLargestSpecial(S[i + 1:j]) + '0')
                i = j + 1

        specials.sort(reverse=True)
        return ''.join(specials)