from collections import deque

def minMutation(start: str, end: str, bank: List[str]) -> int:
    bank_set = set(bank)
    if end not in bank_set:
        return -1

    def is_one_mutation(s1, s2):
        diff = 0
        for c1, c2 in zip(s1, s2):
            if c1 != c2:
                diff += 1
                if diff > 1:
                    return False
        return diff == 1

    queue = deque([(start, 0)])
    visited = {start}

    while queue:
        current, steps = queue.popleft()
        if current == end:
            return steps
        for gene in bank_set:
            if gene not in visited and is_one_mutation(current, gene):
                visited.add(gene)
                queue.append((gene, steps + 1))

    return -1