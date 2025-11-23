class Solution:
    def cycleLengthQueries(self, n: int, queries: list[list[int]]) -> list[int]:
        result = []
        for node1, node2 in queries:
            length = 0
            path1 = []
            path2 = []

            temp_node1 = node1
            while temp_node1 > 0:
                path1.append(temp_node1)
                temp_node1 //= 2

            temp_node2 = node2
            while temp_node2 > 0:
                path2.append(temp_node2)
                temp_node2 //= 2

            path1.reverse()
            path2.reverse()

            i = 0
            while i < min(len(path1), len(path2)) and path1[i] == path2[i]:
                i += 1

            length = len(path1) + len(path2) - 2 * i + 2

            result.append(length)
        return result