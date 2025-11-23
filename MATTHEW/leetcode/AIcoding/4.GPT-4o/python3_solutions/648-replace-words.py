class Solution:
    def replaceWords(self, dictionary: List[str], sentence: str) -> str:
        trie = {}

        for root in dictionary:
            node = trie
            for char in root:
                if char not in node:
                    node[char] = {}
                node = node[char]
            node['$'] = True

        def replace(word):
            node = trie
            for i, char in enumerate(word):
                if char in node:
                    if '$' in node[char]:
                        return word[:i + 1]
                    node = node[char]
                else:
                    break
            return word

        words = sentence.split()
        return ' '.join(replace(word) for word in words)