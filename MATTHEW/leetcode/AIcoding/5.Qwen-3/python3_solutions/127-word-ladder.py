from collections import deque, defaultdict

class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: List[str]) -> int:
        if endWord not in wordList:
            return 0
        L = len(beginWord)
        all_combo_dict = defaultdict(list)
        for word in wordList:
            for i in range(L):
                all_combo_dict[word[:i] + '*' + word[i+1:]].append(word)
        queue = deque([(beginWord, 1)])
        visited = set([beginWord])
        while queue:
            current_word, level = queue.popleft()
            for i in range(L):
                key = current_word[:i] + '*' + current_word[i+1:]
                for next_word in all_combo_dict[key]:
                    if next_word not in visited:
                        if next_word == endWord:
                            return level + 1
                        visited.add(next_word)
                        queue.append((next_word, level + 1))
        return 0