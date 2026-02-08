import collections

class Solution:
    def findLadders(self, beginWord: str, endWord: str, wordList: list[str]) -> list[list[str]]:
        word_set = set(wordList)
        if endWord not in word_set:
            return []

        graph = collections.defaultdict(list)
        dist = {}

        q = collections.deque()
        q.append(beginWord)
        dist[beginWord] = 0

        found_end = False

        while q and not found_end:
            level_size = len(q)
            words_discovered_in_current_level = set() 

            for _ in range(level_size):
                curr_word = q.popleft()

                for i in range(len(curr_word)):
                    original_char = curr_word[i]
                    for char_code in range(ord('a'), ord('z') + 1):
                        new_char = chr(char_code)
                        if new_char == original_char:
                            continue

                        next_word_list = list(curr_word)
                        next_word_list[i] = new_char
                        next_word = "".join(next_word_list)

                        if next_word in word_set: 
                            graph[curr_word].append(next_word)

                            if next_word not in dist:
                                dist[next_word] = dist[curr_word] + 1
                                q.append(next_word)
                                words_discovered_in_current_level.add(next_word)
                                if next_word == endWord:
                                    found_end = True

            for word in words_discovered_in_current_level:
                word_set.discard(word)

        if not found_end:
            return []

        results = []
        current_path = [beginWord]

        def dfs(curr_word, current_path):
            if curr_word == endWord:
                results.append(list(current_path))
                return

            for next_word in graph[curr_word]:
                if dist[next_word] == dist[curr_word] + 1:
                    current_path.append(next_word)
                    dfs(next_word, current_path)
                    current_path.pop()

        dfs(beginWord, current_path)
        return results