class Solution:
    def groupStrings(self, words: List[str]) -> List[int]:
        def get_mask(word):
            mask = 0
            for char in word:
                mask |= (1 << (ord(char) - ord('a')))
            return mask

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x != root_y:
                parent[root_x] = root_y
                return True
            return False

        n = len(words)
        masks = [get_mask(word) for word in words]
        parent = list(range(n))
        count = n

        for i in range(n):
            for j in range(i + 1, n):
                if bin(masks[i] ^ masks[j]).count('1') <= 2:
                    if union(i, j):
                        count -= 1

        sizes = {}
        for i in range(n):
            root = find(i)
            sizes[root] = sizes.get(root, 0) + 1

        return [count, max(sizes.values())]