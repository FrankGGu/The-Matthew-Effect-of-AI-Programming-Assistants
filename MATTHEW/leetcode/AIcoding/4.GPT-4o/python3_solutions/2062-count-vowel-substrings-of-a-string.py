class Solution:
    def countVowelSubstrings(self, word: str) -> int:
        vowels = set('aeiou')
        n = len(word)
        count = 0

        for i in range(n):
            if word[i] in vowels:
                seen = set()
                for j in range(i, n):
                    if word[j] in vowels:
                        seen.add(word[j])
                        if len(seen) == 5:
                            count += 1
                    else:
                        break

        return count