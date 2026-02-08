from collections import deque

class Solution:
    def ladderLength(self, beginWord: str, endWord: str, wordList: list[str]) -> int:
        word_set = set(wordList)

        if endWord not in word_set:
            return 0

        queue = deque([(beginWord, 1)])

        # We use word_set itself to keep track of visited words
        # by removing them once they are processed.
        # beginWord is not in word_set by problem constraint,
        # so it's effectively "visited" once we add it to the queue.

        while queue:
            current_word, current_length = queue.popleft()

            if current_word == endWord:
                return current_length

            # Generate all possible one-character transformations
            for i in range(len(current_word)):
                original_char = current_word[i]
                for char_code in range(ord('a'), ord('z') + 1):
                    char = chr(char_code)

                    # Optimization: no need to change if char is the same
                    if char == original_char:
                        continue

                    next_word = list(current_word)
                    next_word[i] = char
                    next_word = "".join(next_word)

                    # If the transformed word is in our word_set (meaning it's a valid, unvisited word)
                    if next_word in word_set:
                        word_set.remove(next_word)  # Mark as visited
                        queue.append((next_word, current_length + 1))

        return 0