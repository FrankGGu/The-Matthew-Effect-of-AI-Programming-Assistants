from collections import deque, defaultdict

class Solution:
    def findLadders(self, beginWord: str, endWord: str, wordList: List[str]) -> List[List[str]]:
        wordSet = set(wordList)
        if endWord not in wordSet:
            return []

        layer = {}
        layer[beginWord] = [[beginWord]]

        while layer:
            newLayer = defaultdict(list)
            for word in layer:
                if word == endWord:
                    return layer[word]
                for i in range(len(word)):
                    for c in 'abcdefghijklmnopqrstuvwxyz':
                        newWord = word[:i] + c + word[i+1:]
                        if newWord in wordSet:
                            newLayer[newWord] += [path + [newWord] for path in layer[word]]

            wordSet -= set(newLayer.keys())
            layer = newLayer

        return []