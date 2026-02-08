class Solution:
    def kthSmallestPath(self, destination: List[int], k: int) -> str:
        v, h = destination
        res = []
        remaining_down = v
        for i in range(h + v):
            remaining_steps = h + v - i - 1
            c = comb(remaining_steps, remaining_down)
            if c >= k:
                res.append('H')
                h -= 1
            else:
                res.append('V')
                k -= c
                remaining_down -= 1
        return ''.join(res)