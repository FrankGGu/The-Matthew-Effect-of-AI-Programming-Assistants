class Solution:
    def countCombinations(self, pieces: list[str], positions: list[list[int]]) -> int:
        n = len(pieces)
        directions = {
            "rook": [(0, 1), (0, -1), (1, 0), (-1, 0)],
            "bishop": [(1, 1), (1, -1), (-1, 1), (-1, -1)],
            "queen": [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)],
        }

        def check_collision(paths):
            for i in range(n):
                for j in range(i + 1, n):
                    path1 = paths[i]
                    path2 = paths[j]

                    s1 = set(path1)
                    s2 = set(path2)

                    intersection = s1.intersection(s2)
                    if not intersection:
                        continue

                    intersection = sorted(list(intersection))

                    idx1 = [path1.index(p) for p in intersection]
                    idx2 = [path2.index(p) for p in intersection]

                    idx1.sort()
                    idx2.sort()

                    if idx1[0] != idx2[0]:
                        return True
            return False

        def get_paths(direction):
            paths = [[] for _ in range(n)]

            for i in range(n):
                r, c = positions[i]
                dr, dc = direction[i]

                path = [(r, c)]
                while 1 <= r + dr <= 8 and 1 <= c + dc <= 8:
                    r += dr
                    c += dc
                    path.append((r, c))

                paths[i] = path

            return paths

        def generate_directions():
            all_directions = []

            def backtrack(index, current_direction):
                if index == n:
                    all_directions.append(current_direction[:])
                    return

                for direction in directions[pieces[index]]:
                    current_direction.append(direction)
                    backtrack(index + 1, current_direction)
                    current_direction.pop()

            backtrack(0, [])
            return all_directions

        all_directions = generate_directions()

        count = 0
        for direction in all_directions:
            paths = get_paths(direction)

            max_len = 0
            for path in paths:
                max_len = max(max_len, len(path) -1)

            num_steps = [0] * n
            def backtrack(step):
                if step == max_len + 1:
                    if not check_collision([paths[i][:num_steps[i]+1] for i in range(n)]):
                         return 1
                    else:
                        return 0

                res = 0
                for i in range(n):
                    if num_steps[i] < len(paths[i]) - 1:
                        num_steps[i] += 1
                        res += backtrack(step + 1)
                        num_steps[i] -= 1
                return res

            count += backtrack(1)

        return count