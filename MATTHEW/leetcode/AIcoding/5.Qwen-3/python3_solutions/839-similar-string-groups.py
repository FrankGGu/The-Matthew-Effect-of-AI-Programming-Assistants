class Solution:
    def numSimilarGroups(self, A: List[str]) -> int:
        from collections import defaultdict, deque

        def get_neighbors(word):
            neighbors = set()
            for i in range(len(word)):
                for j in range(i + 1, len(word)):
                    word_list = list(word)
                    word_list[i], word_list[j] = word_list[j], word_list[i]
                    neighbors.add(''.join(word_list))
            return neighbors

        visited = set()
        groups = 0
        queue = deque()

        for word in A:
            if word not in visited:
                groups += 1
                queue.append(word)
                visited.add(word)
                while queue:
                    current = queue.popleft()
                    for neighbor in get_neighbors(current):
                        if neighbor not in visited:
                            visited.add(neighbor)
                            queue.append(neighbor)
        return groups