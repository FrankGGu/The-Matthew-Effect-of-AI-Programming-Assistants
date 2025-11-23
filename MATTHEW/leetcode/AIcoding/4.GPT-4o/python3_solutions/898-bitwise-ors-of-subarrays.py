class Solution:
    def subarrayBitwiseORs(self, A: List[int]) -> List[int]:
        result = set()
        current = set()
        for num in A:
            current = {num | x for x in current} | {num}
            result |= current
        return list(result)