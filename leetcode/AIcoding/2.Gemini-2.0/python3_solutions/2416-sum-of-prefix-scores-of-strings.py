class Solution:
    def sumPrefixScores(self, words: List[str]) -> List[int]:
        trie = {}
        for word in words:
            curr = trie
            for char in word:
                if char not in curr:
                    curr[char] = {}
                curr = curr[char]
            curr['#'] = True

        counts = {}
        def traverse(node, prefix):
            if '#' in node:
                counts[prefix] = counts.get(prefix, 0) + 1
            for char in node:
                if char != '#':
                    traverse(node[char], prefix + char)

        traverse(trie, '')

        result = []
        for word in words:
            score = 0
            prefix = ''
            for char in word:
                prefix += char
                score += counts.get(prefix, 0)
            result.append(score)
        return result