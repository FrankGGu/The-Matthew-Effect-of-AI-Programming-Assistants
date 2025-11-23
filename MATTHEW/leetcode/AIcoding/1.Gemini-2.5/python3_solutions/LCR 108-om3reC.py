import collections

class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: list[str]) -> int:
        word_set = set(wordList)
        if endWord not in word_set:
            return 0

        queue = collections.deque([(beginWord, 1)])
        visited = {beginWord}

        while queue:
            current_word, distance = queue.popleft()

            if current_word == endWord:
                return distance

            for i in range(len(current_word)):
                original_char = current_word[i]
                for char_code in range(ord('a'), ord('z') + 1):
                    new_char = chr(char_code)
                    if new_char == original_char:
                        continue

                    next_word_list = list(current_word)
                    next_word_list[i] = new_char
                    next_word = "".join(next_word_list)

                    if next_word in word_set and next_word not in visited:
                        visited.add(next_word)
                        queue.append((next_word, distance + 1))

        return 0