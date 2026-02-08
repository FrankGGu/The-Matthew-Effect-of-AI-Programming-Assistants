class Solution:
    def countPalindromePaths(self, parent: List[int], s: str) -> int:
        from collections import defaultdict

        n = len(parent)
        children = defaultdict(list)
        for i in range(1, n):
            children[parent[i]].append(i)

        mask = 0
        res = 0
        count = defaultdict(int)
        count[0] = 1

        stack = [(0, 0)]

        while stack:
            node, mask = stack.pop()
            for child in children[node]:
                new_mask = mask ^ (1 << (ord(s[child]) - ord('a')))
                res += count[new_mask]
                for i in range(26):
                    res += count[new_mask ^ (1 << i)]
                count[new_mask] += 1
                stack.append((child, new_mask))

        return res