from collections import defaultdict

class Solution:
    def findLadders(self, beginWord: str, endWord: str, wordList: list[str]) -> list[list[str]]:
        wordList = set(wordList)
        if endWord not in wordList:
            return []

        neighbors = defaultdict(list)
        wordList.add(beginWord)
        for word in wordList:
            for i in range(len(word)):
                pattern = word[:i] + "*" + word[i+1:]
                neighbors[pattern].append(word)

        queue = [(beginWord, [beginWord])]
        visited = {beginWord}
        result = []
        found = False

        while queue and not found:
            new_queue = []
            new_visited = set()
            for word, path in queue:
                for i in range(len(word)):
                    pattern = word[:i] + "*" + word[i+1:]
                    for neighbor in neighbors[pattern]:
                        if neighbor == endWord:
                            result.append(path + [endWord])
                            found = True
                        elif neighbor not in visited:
                            if neighbor not in new_visited:
                                new_queue.append((neighbor, path + [neighbor]))
                                new_visited.add(neighbor)
            queue = new_queue
            visited.update(new_visited)

        return result