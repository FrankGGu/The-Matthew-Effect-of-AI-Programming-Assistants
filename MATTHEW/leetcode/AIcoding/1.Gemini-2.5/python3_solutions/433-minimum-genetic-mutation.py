import collections

class Solution:
    def minMutation(self, start: str, end: str, bank: list[str]) -> int:
        bank_set = set(bank)

        queue = collections.deque([(start, 0)])
        visited = {start}

        gene_chars = ['A', 'C', 'G', 'T']

        while queue:
            current_gene, mutations = queue.popleft()

            if current_gene == end:
                return mutations

            for i in range(len(current_gene)):
                original_char = current_gene[i]
                for char in gene_chars:
                    if char == original_char:
                        continue

                    next_gene_list = list(current_gene)
                    next_gene_list[i] = char
                    next_gene = "".join(next_gene_list)

                    if next_gene in bank_set and next_gene not in visited:
                        visited.add(next_gene)
                        queue.append((next_gene, mutations + 1))

        return -1