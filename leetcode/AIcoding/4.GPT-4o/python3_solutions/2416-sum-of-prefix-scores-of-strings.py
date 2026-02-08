class Solution:
    def sumPrefixScores(self, words: List[str]) -> List[int]:
        prefix_count = {}
        result = []

        for word in words:
            prefix = ""
            for char in word:
                prefix += char
                if prefix in prefix_count:
                    prefix_count[prefix] += 1
                else:
                    prefix_count[prefix] = 1

        for word in words:
            total_score = 0
            prefix = ""
            for char in word:
                prefix += char
                total_score += prefix_count[prefix]
            result.append(total_score)

        return result