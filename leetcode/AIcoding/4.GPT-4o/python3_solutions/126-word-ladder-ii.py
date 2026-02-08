from collections import defaultdict, deque
from typing import List

class Solution:
    def findLadders(self, beginWord: str, endWord: str, wordList: List[str]) -> List[List[str]]:
        wordList = set(wordList)
        if endWord not in wordList:
            return []

        neighbors = defaultdict(list)
        for word in wordList:
            for i in range(len(word)):
                for c in 'abcdefghijklmnopqrstuvwxyz':
                    newWord = word[:i] + c + word[i+1:]
                    if newWord in wordList and newWord != word:
                        neighbors[word].append(newWord)

        def bfs(start, end):
            queue = deque([start])
            visited = {start: 0}
            while queue:
                word = queue.popleft()
                for neighbor in neighbors[word]:
                    if neighbor not in visited:
                        visited[neighbor] = visited[word] + 1
                        queue.append(neighbor)
                        if neighbor == end:
                            return visited
            return visited

        def backtrack(word, end, path, res):
            if word == end:
                res.append(path[:])
                return
            for neighbor in neighbors[word]:
                if neighbor in visited and visited[neighbor] == visited[word] + 1:
                    path.append(neighbor)
                    backtrack(neighbor, end, path, res)
                    path.pop()

        visited = bfs(beginWord, endWord)
        res = []
        if endWord in visited:
            backtrack(beginWord, endWord, [beginWord], res)
        return res