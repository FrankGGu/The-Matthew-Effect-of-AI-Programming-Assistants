class Solution:
    def numOfBurgers(self, tomatoSlices: int, cheeseSlices: int) -> List[int]:
        total_jumbo = (tomatoSlices - 2 * cheeseSlices) / 2
        total_small = cheeseSlices - total_jumbo
        if total_jumbo >= 0 and total_small >= 0 and total_jumbo == int(total_jumbo):
            return [int(total_jumbo), int(total_small)]
        else:
            return []