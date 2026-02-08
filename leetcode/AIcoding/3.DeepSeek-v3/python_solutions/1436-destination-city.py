class Solution:
    def destCity(self, paths: List[List[str]]) -> str:
        outgoing = set()
        cities = set()

        for path in paths:
            outgoing.add(path[0])
            cities.add(path[0])
            cities.add(path[1])

        for city in cities:
            if city not in outgoing:
                return city