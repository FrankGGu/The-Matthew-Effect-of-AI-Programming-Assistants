class Solution:
    def twoSum(self, price: List[int], target: int) -> List[int]:
        seen = set()
        for p in price:
            complement = target - p
            if complement in seen:
                return [p, complement]
            seen.add(p)
        return []