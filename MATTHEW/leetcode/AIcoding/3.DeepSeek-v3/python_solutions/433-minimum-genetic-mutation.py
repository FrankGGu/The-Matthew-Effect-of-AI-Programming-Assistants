from collections import deque

class Solution:
    def minMutation(self, startGene: str, endGene: str, bank: List[str]) -> int:
        if endGene not in bank:
            return -1

        bank_set = set(bank)
        queue = deque([(startGene, 0)])
        visited = set()
        visited.add(startGene)
        mutations = ['A', 'C', 'G', 'T']

        while queue:
            current_gene, steps = queue.popleft()
            if current_gene == endGene:
                return steps

            for i in range(len(current_gene)):
                for mutation in mutations:
                    if mutation != current_gene[i]:
                        new_gene = current_gene[:i] + mutation + current_gene[i+1:]
                        if new_gene in bank_set and new_gene not in visited:
                            visited.add(new_gene)
                            queue.append((new_gene, steps + 1))

        return -1