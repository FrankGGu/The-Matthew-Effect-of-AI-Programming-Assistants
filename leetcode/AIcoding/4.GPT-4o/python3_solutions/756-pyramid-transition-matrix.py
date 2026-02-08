class Solution:
    def pyramidTransition(self, bottom: List[str], allowed: List[str]) -> bool:
        from collections import defaultdict

        transitions = defaultdict(set)
        for a in allowed:
            transitions[a[0] + a[1]].add(a[2])

        def can_form_pyramid(current):
            if len(current) == 1:
                return True
            next_row = []
            for i in range(len(current) - 1):
                base = current[i] + current[i + 1]
                if base not in transitions:
                    return False
                next_row.append(transitions[base])
            return self.dfs(next_row, 0)

        def dfs(next_row, index):
            if index == len(next_row) - 1:
                return can_form_pyramid(next_row[index])
            for char in next_row[index]:
                if dfs(next_row, index + 1):
                    return True
            return False

        return can_form_pyramid(bottom)