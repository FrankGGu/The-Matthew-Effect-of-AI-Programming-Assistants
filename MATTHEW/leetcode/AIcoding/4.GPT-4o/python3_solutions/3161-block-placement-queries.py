class Solution:
    def blockQueries(self, queries: List[int], m: int) -> List[int]:
        n = len(queries)
        last_position = {}
        result = [0] * n

        for i in range(n):
            block = queries[i] // m
            if block in last_position:
                result[i] = last_position[block] + 1
            last_position[block] = i

        return result