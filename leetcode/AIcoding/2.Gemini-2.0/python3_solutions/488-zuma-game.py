def findMinStep(board: str, hand: str) -> int:
    from collections import Counter, deque

    hand_count = Counter(hand)

    def remove_duplicates(s):
        res = []
        i = 0
        while i < len(s):
            j = i
            while j < len(s) and s[i] == s[j]:
                j += 1
            if j - i >= 3:
                i = j
            else:
                res.extend(s[i:j])
                i = j
        return "".join(res)

    queue = deque([(board, hand_count, 0)])
    visited = set()
    visited.add((board, tuple(sorted(hand_count.items()))))

    while queue:
        curr_board, curr_hand, steps = queue.popleft()

        if not curr_board:
            return steps

        for i in range(len(curr_board) + 1):
            for color in curr_hand:
                if curr_hand[color] > 0:
                    new_board = curr_board[:i] + color + curr_board[i:]
                    new_board = remove_duplicates(new_board)

                    new_hand = curr_hand.copy()
                    new_hand[color] -= 1

                    state = (new_board, tuple(sorted(new_hand.items())))

                    if state not in visited:
                        visited.add(state)
                        queue.append((new_board, new_hand, steps + 1))

    return -1