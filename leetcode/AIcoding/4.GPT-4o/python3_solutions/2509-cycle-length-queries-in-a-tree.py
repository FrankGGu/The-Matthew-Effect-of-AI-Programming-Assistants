class Solution:
    def cycleLengthQueries(self, n: int, queries: List[List[int]]) -> List[int]:
        def find_ancestor(a, b):
            while a != b:
                if a > b:
                    a //= 2
                else:
                    b //= 2
            return a

        result = []
        for a, b in queries:
            ancestor = find_ancestor(a, b)
            result.append(bin(a).count('1') + bin(b).count('1') - 2 * bin(ancestor).count('1') + 1)
        return result