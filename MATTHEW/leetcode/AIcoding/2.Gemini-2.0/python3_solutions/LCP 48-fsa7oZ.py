def solve():
    n = int(input())
    board = [input() for _ in range(n)]
    k = int(input())
    queries = []
    for _ in range(k):
        queries.append(tuple(map(int, input().split())))

    def get_color(r, c):
        if 0 <= r < n and 0 <= c < n:
            return board[r][c]
        return None

    def can_reach(start_r, start_c, end_r, end_c):
        q = [(start_r, start_c, 0)]
        visited = set()
        visited.add((start_r, start_c))

        while q:
            r, c, steps = q.pop(0)

            if r == end_r and c == end_c:
                return True

            dr = [-1, 1, 0, 0]
            dc = [0, 0, -1, 1]

            for i in range(4):
                new_r = r + dr[i]
                new_c = c + dc[i]

                if 0 <= new_r < n and 0 <= new_c < n and (new_r, new_c) not in visited and board[new_r][new_c] == '.':
                    q.append((new_r, new_c, steps + 1))
                    visited.add((new_r, new_c))

        return False

    for start_r, start_c, end_r, end_c in queries:
        if can_reach(start_r - 1, start_c - 1, end_r - 1, end_c - 1):
            print("YES")
        else:
            print("NO")

solve()