from collections import deque

class Solution:
    def minMutation(self, start: str, end: str, bank: list[str]) -> int:
        bank = set(bank)
        if end not in bank:
            return -1

        q = deque([(start, 0)])
        visited = {start}

        while q:
            gene, steps = q.popleft()

            if gene == end:
                return steps

            for i in range(len(gene)):
                for char in "ACGT":
                    new_gene = gene[:i] + char + gene[i+1:]
                    if new_gene in bank and new_gene not in visited:
                        q.append((new_gene, steps + 1))
                        visited.add(new_gene)

        return -1