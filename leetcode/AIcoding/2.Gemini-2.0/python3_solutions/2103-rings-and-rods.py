class Solution:
    def countPoints(self, rings: str) -> int:
        rods = {}
        for i in range(0, len(rings), 2):
            color = rings[i]
            rod_num = int(rings[i+1])
            if rod_num not in rods:
                rods[rod_num] = set()
            rods[rod_num].add(color)

        count = 0
        for rod_num in rods:
            if len(rods[rod_num]) == 3:
                count += 1

        return count