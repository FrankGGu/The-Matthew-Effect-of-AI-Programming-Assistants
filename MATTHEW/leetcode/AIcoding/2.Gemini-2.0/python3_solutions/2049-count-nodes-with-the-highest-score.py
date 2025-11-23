class Solution:
    def countHighestScoreNodes(self, parents: List[int]) -> int:
        n = len(parents)
        children = [[] for _ in range(n)]
        for i, p in enumerate(parents):
            if p != -1:
                children[p].append(i)

        counts = {}

        def dfs(node):
            size = 1
            mult = 1
            for child in children[node]:
                child_size = dfs(child)
                size += child_size
                mult *= child_size

            rem = n - size
            if rem > 0:
                mult *= rem

            if mult not in counts:
                counts[mult] = 0
            counts[mult] += 1

            return size

        dfs(0)

        max_score = max(counts.keys())
        return counts[max_score]