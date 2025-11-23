class Solution:
    def minQueenMoves(self, queen: str, target: str) -> int:
        def get_distance(q, t):
            return max(abs(ord(q[0]) - ord(t[0])), abs(int(q[1]) - int(t[1])))

        return get_distance(queen, target)