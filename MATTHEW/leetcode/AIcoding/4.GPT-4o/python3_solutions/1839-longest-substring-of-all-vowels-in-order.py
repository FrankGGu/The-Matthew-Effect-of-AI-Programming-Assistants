class Solution:
    def longestBeautifulSubstring(self, word: str) -> int:
        vowels = 'aeiou'
        max_length = 0
        current_length = 0
        count = 0

        for i in range(len(word)):
            if i == 0 or word[i] != word[i - 1]:
                if word[i] in vowels:
                    count = (count + 1) if (count < 5 and word[i] == vowels[count]) else 1
                    current_length = 1
                else:
                    count = 0
                    current_length = 0
            if count > 0:
                current_length += 1
                if count == 5:
                    max_length = max(max_length, current_length)

        return max_length