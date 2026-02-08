class Solution:
    def addToArrayForm(self, num: List[int], k: int) -> List[int]:
        num_int = int(''.join(map(str, num)))
        total = num_int + k
        return list(map(int, list(str(total))))