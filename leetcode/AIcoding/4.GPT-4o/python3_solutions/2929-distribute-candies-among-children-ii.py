def distributeCandies(candies: int, num_people: int) -> List[int]:
    res = [0] * num_people
    k = 0
    while candies > 0:
        k += 1
        for i in range(num_people):
            if candies >= k:
                res[i] += k
                candies -= k
            else:
                res[i] += candies
                return res
    return res