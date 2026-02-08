class Solution:
    def findMinStep(self, board: str, hand: str) -> int:
        from collections import defaultdict

        def remove_consecutive(s):
            stack = []
            for c in s:
                if stack and stack[-1][0] == c:
                    stack[-1] = (c, stack[-1][1] + 1)
                else:
                    stack.append((c, 1))
                if stack[-1][1] >= 3:
                    stack.pop()
            return ''.join([c * cnt for c, cnt in stack])

        hand_count = defaultdict(int)
        for c in hand:
            hand_count[c] += 1

        memo = {}

        def dfs(board, hand_count):
            if not board:
                return 0
            key = (board, tuple(sorted(hand_count.items())))
            if key in memo:
                return memo[key]
            res = float('inf')
            i = 0
            n = len(board)
            while i < n:
                j = i
                while j < n and board[j] == board[i]:
                    j += 1
                needed = 3 - (j - i)
                if hand_count[board[i]] >= needed:
                    new_hand_count = hand_count.copy()
                    new_hand_count[board[i]] -= needed
                    new_board = board[:i] + board[j:]
                    new_board = remove_consecutive(new_board)
                    temp = dfs(new_board, new_hand_count)
                    if temp != -1:
                        res = min(res, temp + needed)
                i = j
            memo[key] = res if res != float('inf') else -1
            return memo[key]

        return dfs(board, hand_count)