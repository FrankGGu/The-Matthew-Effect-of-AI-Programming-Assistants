from collections import deque

class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: List[str]) -> int:
        wordSet = set(wordList)
        if endWord not in wordSet:
            return 0

        queue = deque([(beginWord, 1)])

        while queue:
            currentWord, length = queue.popleft()
            if currentWord == endWord:
                return length

            for i in range(len(currentWord)):
                for c in 'abcdefghijklmnopqrstuvwxyz':
                    nextWord = currentWord[:i] + c + currentWord[i+1:]
                    if nextWord in wordSet:
                        wordSet.remove(nextWord)
                        queue.append((nextWord, length + 1))

        return 0