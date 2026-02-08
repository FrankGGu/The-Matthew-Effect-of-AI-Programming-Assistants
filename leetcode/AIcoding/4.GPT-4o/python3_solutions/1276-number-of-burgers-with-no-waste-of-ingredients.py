def numOfBurgers(tomatoSlices: int, cheeseSlices: int):
    if tomatoSlices % 2 != 0 or tomatoSlices < 2 * cheeseSlices or tomatoSlices > 4 * cheeseSlices:
        return []
    jumbo = (tomatoSlices - 2 * cheeseSlices) // 2
    small = cheeseSlices - jumbo
    return [jumbo, small]