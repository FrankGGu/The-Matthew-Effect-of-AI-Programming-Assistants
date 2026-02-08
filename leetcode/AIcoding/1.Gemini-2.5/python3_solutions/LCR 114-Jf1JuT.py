import collections

class Solution:
    def alienOrder(self, words: list[str]) -> str:
        # 1. Initialize data structures
        # adj: Adjacency list to store the graph (char -> list of chars that must come after it)
        adj = collections.defaultdict(list)
        # in_degree: Count of incoming edges for each character
        in_degree = collections.defaultdict(int)
        # all_chars: Set of all unique characters present in the words
        all_chars = set()

        # Populate all_chars with all unique characters from words
        for word in words:
            for char in word:
                all_chars.add(char)

        # Initialize in_degree for all characters to 0
        for char in all_chars:
            in_degree[char] = 0

        # 2. Build the graph (adjacency list and in-degrees)
        # Iterate through adjacent word pairs to find ordering rules
        for i in range(len(words) - 1):
            word1 = words[i]
            word2 = words[i+1]

            # Edge case: If word1 is a prefix of word2, but word1 is longer (e.g., "abc", "ab"),
            # this indicates an invalid lexicographical order.
            if len(word1) > len(word2) and word1.startswith(word2):
                return ""

            # Find the first differing character between word1 and word2
            for j in range(min(len(word1), len(word2))):
                char1 = word1[j]
                char2 = word2[j]
                if char1 != char2:
                    # If char1 comes before char2, add an edge char1 -> char2
                    # Only add the edge if it doesn't already exist to avoid
                    # incorrect in-degree counts for cycles or redundant rules.
                    if char2 not in adj[char1]:
                        adj[char1].append(char2)
                        in_degree[char2] += 1
                    # Important: Once the first differing character is found,
                    # no further characters in this pair provide ordering information.
                    break 

        # 3. Perform Topological Sort using Kahn's algorithm (BFS)
        queue = collections.deque()
        # Add all characters with an in-degree of 0 to the queue
        for char in all_chars:
            if in_degree[char] == 0:
                queue.append(char)

        result = []
        while queue:
            u = queue.popleft()
            result.append(u)

            # For each neighbor 'v' of 'u'
            for v in adj[u]:
                in_degree[v] -= 1
                # If 'v's in-degree becomes 0, it means all its prerequisites have been processed
                if in_degree[v] == 0:
                    queue.append(v)

        # 4. Check for cycles
        # If the length of the topological sort result is not equal to the total number of unique characters,
        # it means there was a cycle in the graph, and no valid order exists.
        if len(result) == len(all_chars):
            return "".join(result)
        else:
            return ""