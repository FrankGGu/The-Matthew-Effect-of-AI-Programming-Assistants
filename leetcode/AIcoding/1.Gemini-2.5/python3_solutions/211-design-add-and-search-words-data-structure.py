class WordDictionary:

    def __init__(self):
        self.trie = {}

    def addWord(self, word: str) -> None:
        node = self.trie
        for char in word:
            if char not in node:
                node[char] = {}
            node = node[char]
        node['#'] = True  # Mark end of a word

    def search(self, word: str) -> bool:

        def dfs(node, index):
            if index == len(word):
                return '#' in node

            char = word[index]

            if char == '.':
                for child_char in node:
                    if child_char != '#' and dfs(node[child_char], index + 1):
                        return True
                return False
            else:
                if char in node:
                    return dfs(node[char], index + 1)
                else:
                    return False

        return dfs(self.trie, 0)