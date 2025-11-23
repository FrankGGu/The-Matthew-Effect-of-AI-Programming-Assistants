def distributeCandies(candies: List[int]) -> int:
    return min(len(candies) // 2, len(set(candies)))