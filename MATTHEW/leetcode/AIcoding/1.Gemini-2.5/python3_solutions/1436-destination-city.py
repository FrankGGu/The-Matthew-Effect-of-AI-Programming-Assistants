class Solution:
    def destCity(self, paths: list[list[str]]) -> str:
        outgoing_cities = set()
        for path in paths:
            outgoing_cities.add(path[0])

        for path in paths:
            if path[1] not in outgoing_cities:
                return path[1]
        return ""