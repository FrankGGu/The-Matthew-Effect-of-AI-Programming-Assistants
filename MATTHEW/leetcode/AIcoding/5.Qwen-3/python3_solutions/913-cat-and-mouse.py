class Solution:
    def catMouseGame(self, graph: List[List[int]], catJump: int, mouseJump: int) -> int:
        from collections import deque

        MOUSE_WIN, CAT_WIN, DRAW = 0, 1, 2
        N = len(graph)
        memo = {}

        def get_result(mouse, cat, turn):
            if turn > 2 * N:
                return DRAW
            if (mouse, cat, turn) in memo:
                return memo[(mouse, cat, turn)]
            if mouse == 0:
                memo[(mouse, cat, turn)] = MOUSE_WIN
                return MOUSE_WIN
            if mouse == cat:
                memo[(mouse, cat, turn)] = CAT_WIN
                return CAT_WIN

            if turn % 2 == 0:
                # Mouse's turn
                res = CAT_WIN
                for next_mouse in graph[mouse]:
                    if next_mouse <= mouse + mouseJump:
                        result = get_result(next_mouse, cat, turn + 1)
                        if result == MOUSE_WIN:
                            res = MOUSE_WIN
                            break
                memo[(mouse, cat, turn)] = res
                return res
            else:
                # Cat's turn
                res = MOUSE_WIN
                for next_cat in graph[cat]:
                    if next_cat <= cat + catJump:
                        result = get_result(mouse, next_cat, turn + 1)
                        if result == CAT_WIN:
                            res = CAT_WIN
                            break
                memo[(mouse, cat, turn)] = res
                return res

        return get_result(1, 2, 0)