class Solution:
    def solve(self, tomatoSlices: int, cheeseSlices: int) -> list[int]:
        jumbo = (tomatoSlices - 2 * cheeseSlices) / 2
        small = cheeseSlices - jumbo
        if jumbo >= 0 and small >= 0 and jumbo == int(jumbo) and small == int(small):
            return [int(jumbo), int(small)]
        else:
            return []

    def numberOfBurgers(self, tomatoSlices: int, cheeseSlices: int) -> list[int]:
        return self.solve(tomatoSlices, cheeseSlices)