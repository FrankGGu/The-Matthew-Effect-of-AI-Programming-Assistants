class Solution:
    def maxNumberOfBalloons(self, text: str) -> int:
        count = {}
        for char in text:
            count[char] = count.get(char, 0) + 1

        balloon_counts = {'b': 0, 'a': 0, 'l': 0, 'o': 0, 'n': 0}

        for char in balloon_counts:
            if char in count:
                balloon_counts[char] = count[char]
            else:
                return 0

        result = min(balloon_counts['b'], balloon_counts['a'], balloon_counts['n'], balloon_counts['l'] // 2, balloon_counts['o'] // 2)
        return result