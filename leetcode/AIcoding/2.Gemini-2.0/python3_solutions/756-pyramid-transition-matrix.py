class Solution:
    def pyramidTransition(self, bottom: str, allowed: List[str]) -> bool:
        allowed_dict = defaultdict(set)
        for s in allowed:
            allowed_dict[s[:2]].add(s[2])

        def solve(row):
            if len(row) == 1:
                return True

            next_row = []

            def generate_next(i, current_next):
                if i == len(row) - 1:
                    next_row.append("".join(current_next))
                    return

                pair = row[i:i+2]
                if pair in allowed_dict:
                    for c in allowed_dict[pair]:
                        generate_next(i+1, current_next + [c])

            generate_next(0, [])

            for next_r in next_row:
                if solve(next_r):
                    return True

            return False

        return solve(bottom)