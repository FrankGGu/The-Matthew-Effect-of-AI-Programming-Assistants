def numJewelsInStones(jewels: str, stones: str) -> int:
    return sum(stone in jewels for stone in stones)