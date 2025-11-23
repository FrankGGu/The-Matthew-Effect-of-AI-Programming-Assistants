from collections import deque

class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: list[str]) -> int:
        wordSet = set(wordList)
        if endWord not in wordSet:
            return 0

        queue = deque([(beginWord, 1)])
        visited = {beginWord}

        while queue:
            word, length = queue.popleft()

            if word == endWord:
                return length

            for i in range(len(word)):
                for char_code in range(ord('a'), ord('z') + 1):
                    new_word = word[:i] + chr(char_code) + word[i+1:]

                    if new_word in wordSet and new_word not in visited:
                        queue.append((new_word, length + 1))
                        visited.add(new_word)

        return 0